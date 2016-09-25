Base.start(::Section) = Cint(1)

Base.next(::Section, state::Cint) = (state, state + Cint(1))

Base.done(s::Section, state::Cint) = state > length(s)

Base.eltype(::Section) = Cint

Base.length(::Section) = Cint(0)

Base.length(s::DefaultNodeSection) = s.cnt

Base.length(s::DefaultSegmentSection) = s.cnt

Base.length(s::SkipDefaultHoleSection) = s.cnt

Base.length(s::DefaultHoleSection) = s.cnt

Base.length(s::DefaultRegionSection) = s.cnt

Base.length(s::DefaultElementSection) = s.cnt

Base.length(s::DefaultAreaSection) = s.cnt

is_empty(::NodeSection) = true

is_empty(::DefaultNodeSection) = false

get_start_index(::NodeSection) = Cint(1)

get_start_index(fs::DefaultNodeSection) = fs.start_index

function apply_parsers(
  s::Section, line::Vector{SubString{String}}, parsers::Vector{Parser},
  index::Cint
)
  for parser in parsers
    vector = parser.vector
    args = parser.args
    parser.func(getfield(s, vector), line, index, args...)
  end
end

function parse_line(
  s::Section, line::Vector{SubString{String}}, parsers::Vector{Parser},
  index::Cint
)
  apply_parsers(s, line, parsers, index)
end

function parse_line(
  s::SkipDefaultHoleSection, line::Vector{SubString{String}},
  parsers::Vector{Parser}, index::Cint
)
end

function parse_line(
  s::DefaultNodeSection, line::Vector{SubString{String}},
  parsers::Vector{Parser}, index::Cint
)
  if index === Cint(1)
    s.start_index = parse(Cint, line[1])
  end
  apply_parsers(s, line, parsers, index)
end

function read(s::Section, fis::IOStream, parsers::Vector{Parser})
  for i in s
    parse_line(s, read_file_line(fis), parsers, i)
  end
end

read(::Section, ::IOStream) = return

function read(s::DefaultNodeSection, fis::IOStream)
  has_markers = length(s.markers) > 0
  has_attrs = s.attr_cnt > Cint(0)
  if has_attrs == true && has_markers == true
    read(s, fis, [
      Parser(parse_points, (Cint(2), ), :points),
      Parser(parse_attrs, (Cint(4), s.attr_cnt), :attrs),
      Parser(parse_markers, (Cint(4 + s.attr_cnt), ), :markers)
    ])
  elseif has_attrs == true
    read(s, fis, [
      Parser(parse_points, (Cint(2), ), :points),
      Parser(parse_attrs, (Cint(4), s.attr_cnt), :attrs)
    ])
  elseif has_markers == true
    read(s, fis, [
      Parser(parse_points, (Cint(2), ), :points),
      Parser(parse_markers, (Cint(4), ), :markers)
    ])
  else
    read(s, fis, [
      Parser(parse_points, (Cint(2), ), :points)
    ])
  end
end

function read(s::DefaultSegmentSection, fis::IOStream)
  if length(s.markers) > 0
    read(s, fis, [
      Parser(parse_segments, (Cint(2), s.start_index), :segments),
      Parser(parse_markers, (Cint(4), ), :markers)
    ])
  else
    read(s, fis, [
      Parser(parse_segments, (Cint(2), s.start_index), :segments)
    ])
  end
end

function read(s::DefaultHoleSection, fis::IOStream)
  read(s, fis, [
    Parser(parse_holes, (Cint(2), ), :holes)
  ])
end

function read(s::SkiptDefaultHoleSection, fis::IOStream)
  read(s, fis, [])
end

function read(s::DefaultRegionSection, fis::IOStream)
  read(s, fis, [
    Parser(parse_regions, (Cint(2), ), :regions)
  ])
end

function read(s::DefaultElementSection, fis::IOStream)
  if s.attr_cnt > Cint(0)
    read(s, fis, [
      Parser(parse_elems, (Cint(2), s.corner_cnt, s.start_index), :regions),
      Parser(parse_attrs, (Cint(2) + s.corner_cnt, s.attr_cnt), :attrs)
    ])
  else
    read(s, fis, [
      Parser(parse_elems, (Cint(2), s.corner_cnt, s.start_index), :regions)
    ])
  end
end

function read(s::DefaultAreaSection, fis::IOStream)
  read(s, fis, [
    Parser(parse_areas, (Cint(2), ), :areas)
  ])
end
