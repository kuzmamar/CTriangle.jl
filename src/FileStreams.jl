const COMMENT = '#'

read_line(s::IOStream) = strip(readline(s))

read_clear_line(s::IOStream) = read_clear_line(read_line(s), s)

function read_clear_line(line::String, s::IOStream)
	tmp = line
	while searchindex(tmp, COMMENT, 1) == 1
		tmp = read_line(s)
	end
	tmp
end

read_file_line(is::IOStream) = split(read_clear_line(is))

abstract FileStream

type NodeFileStream <: FileStream
  is::IOStream
end

type PolyFileStream <: FileStream
  filename::String
  is::IOStream
end

type

read(::FileStream) = error("Implement method read")

function read_header(fs::NodeFileStream)
  line = read_file_line(fs.is)
  (parse(Cint, line[1]), parse(Cint, line[2]),
   parse(Cint, line[3]), parse(Cint, line[4]))
end

function read(fs::NodeFileStream)
  cnt, dim, attr_cnt, marker = read_header(fs)
  file = cnt == 0 ? NodeFile(NoNodeSection()) :
                    NodeFile(DefaultNodeSection(cnt, Vector{Cint}(2 * cnt),
                                       Vector{Cdouble}(cnt * attr_cnt), attr_cnt,
                                       marker > 0 ? Vector{Cint}(cnt) : Vector{Cint}[]))
  read(file, fs.is)
  file
end

function read(fs::PolyFileStream)
  nf = read(NodeFileStream(fs.is))
  if is_empty(nf)
    nfs = create_stream(NodeFileName(fs.filename))
    nf = read(nfs)
  end
  ss = read(SegmentSection(fs.is))
  hs = read(HoleSection(fs.is))
  rs = read(RegionSection(fs.is))
  PolyFile(get_section(nf), ss, hs, rs)
end
