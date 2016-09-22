Base.start(::FileSection) = 1

Base.next(::FileSection, state::Cint) = (state, state + 1)

Base.done(fs::FileSection, state::Cint) = state > length(fs)

Base.eltype(::FileSection) = Cint

Base.length(::FileSection) = Cint(0)

read(::NodeSection, ::IOStream) = return

function read(fs::FileSection, is::IOStream, parsers::Vector{Parser})
  for i in fs
    line = read_file_line(is)
    for parser in parsers
      vector = parser.vector
      args = parser.args
      parser.func(fs.vector, line, i, args...)
    end
  end
end

function read(fs::DefaultNodeSection, is::IOStream)
  has_markers = size(fs.markers) > 0
  has_attrs = f.attr_cnt > 0
  attrs_end = Cint(4 + fs.attr_cnt)

  if has_attrs == true && has_markers == true
    read(fs, is, [
      Parser(parse_points, (Cint(2)), :points),
      Parser(parse_attrs, (Cint(4), fs.attr_cnt), :attrs),
      Parser(parse_marker, (attrs_end + 1), :markers)
    ])
  elseif has_attrs == true
    read(fs, is, [
      Parser(parse_points, (Cint(2)), :points),
      Parser(parse_attrs, (Cint(4), fs.attr_cnt), :attrs)
    ])
  elseif has_markers == true
    read(fs, is, [
      Parser(parse_points, (Cint(2)), :points),
      Parser(parse_markers, (Cint(4)), :markers)
    ])
  else
    read(fs, is, [
      Parser(parse_points, (Cint(2)), :points)
    ])
  end
end
