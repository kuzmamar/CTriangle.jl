read(::FileStream) = error("Implement method read")

function read_header(fs::NodeFileStream)
  line = read_file_line(fs.is)
  (parse(Cint, line[1]), parse(Cint, line[2]),
   parse(Cint, line[3]), parse(Cint, line[4]))
end

function read(fs::NodeFileStream)
  cnt, dim, attr_cnt, marker = read_header(fs)
  if cnt == 0
    file = NodeFile(NoNodeSection())
  else
    file = NodeFile(
      DefaultNodeSection(
        cnt, Vector{Cint}(2 * cnt), Vector{Cdouble}(cnt * attr_cnt), attr_cnt,
        fs.read_marker == true && marker > 0 ? Vector{Cint}(cnt) :
                                               Vector{Cint}[]))
  end
  read(file, fs.is)
  file
end

function read(fs::PolyFileStream)
  nf = read(NodeFileStream(fs.is, fs.read_marker))
  if is_empty(nf)
    nfs = create_stream(NodeFileName(fs.filename))
    nf = read(nfs)
  end
  ss = read(SegmentSection(fs.is))
  hs = read(HoleSection(fs.is))
  rs = read(RegionSection(fs.is))
  PolyFile(get_section(nf), ss, hs, rs)
end
