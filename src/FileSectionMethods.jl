Base.start(::FileSection) = Cint(1)

Base.next(::FileSection, state::Cint) = (state, state + Cint(1))

Base.done(fs::FileSection, state::Cint) = state > length(fs)

Base.eltype(::FileSection) = Cint

Base.length(::FileSection) = Cint(0)

Base.length(fs::DefaultNodeSection) = fs.cnt

read(::NodeSection, ::IOStream) = return

is_empty(::NodeSection) = true

is_empty(::DefaultNodeSection) = false

function read(fs::FileSection, fis::IOStream, parsers::Vector{Parser})
  for i in fs
    line = read_file_line(fis)
    for parser in parsers
      vector = parser.vector
      args = parser.args
      parser.func(getfield(fs, vector), line, i, args...)
    end
  end
end

function read(fs::DefaultNodeSection, fis::IOStream)
  has_markers = length(fs.markers) > 0
  has_attrs = fs.attr_cnt > 0
  if has_attrs == true && has_markers == true
    read(fs, fis, [
      Parser(parse_points, (Cint(2), ), :points),
      Parser(parse_attrs, (Cint(4), fs.attr_cnt), :attrs),
      Parser(parse_markers, (Cint(4 + fs.attr_cnt), ), :markers)
    ])
  elseif has_attrs == true
    read(fs, fis, [
      Parser(parse_points, (Cint(2), ), :points),
      Parser(parse_attrs, (Cint(4), fs.attr_cnt), :attrs)
    ])
  elseif has_markers == true
    read(fs, fis, [
      Parser(parse_points, (Cint(2), ), :points),
      Parser(parse_markers, (Cint(4), ), :markers)
    ])
  else
    read(fs, fis, [
      Parser(parse_points, (Cint(2), ), :points)
    ])
  end
end
