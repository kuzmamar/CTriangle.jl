Base.close(fs::FileStream) = close(get_stream(fs))

read(::FileStream) = error("Implement method read")

get_stream(::FileStream) = error("Implement method get_stream")

get_stream(fs::NodeFileStream) = fs.fs

get_stream(fs::PolyFileStream) = fs.fs

function read_header(fs::NodeFileStream)
  line = read_file_line(fs.fs)
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
        fs.read_markers == true && marker > 0 ? Vector{Cint}(cnt) :
                                                Vector{Cint}[]))
  end
  read(file, fs.fs)
  file
end

function read(fs::PolyFileStream)
  nf = read(NodeFileStream(fs.fs, fs.read_marker))
  if is_empty(nf)
    nfs = create_stream(NodeFileName(fs.file_name))
    nf = read(nfs)
  end
  ss = read(SegmentSection(fs.fs))
  hs = read(HoleSection(fs.fs))
  rs = read(RegionSection(fs.fs))
  PolyFile(get_section(nf), ss, hs, rs)
end
