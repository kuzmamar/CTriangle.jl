get_stream(ss::SectionStream) = ss.fs

create_no_section(::SectionStream) = error("Implement create_no_section method")

create_no_section(::NodeSectionStream) = NoNodeSection()

create_no_section(::SegmentSectionStream) = NoSegmentSection()

create_no_section(::HoleSectionStream) = NoHoleSection()

create_no_section(::RegionSectionStream) = NoRegionSection()

create_no_section(::ElementSectionStream) = NoElementSection()

create_no_section(::AreaSectionStream) = NoAreaSection()

function create_default_section(::SectionStream, ::Tuple{Vararg{Cint}})
  error("Implement create_default_section method")
end

function create_default_section(ss::NodeSectionStream, header::Tuple{Vararg{Cint}})
  cnt, dim, attr_cnt, marker = header...
  points = Vector{Cdouble}(2 * cnt)
  attrs = Vector{Cdouble}(cnt * attr_cnt)
  markers = create_markers(ss.read_markers, marker)
  DefaultNodeSection(cnt, points, attrs, attr_cnt, markers, Cint(1))
end

function create_default_section(ss::SegmentSectionStream, header::Tuple{Vararg{Cint}})
  cnt, marker = header...
  segments = Vector{Cint}(2 * cnt)
  markers = create_markers(ss.read_markers, marker)
  DefaultSegmentSection(cnt, segments, markers, ss.start_index)
end

function create_default_section(ss::HoleSectionStream, header::Tuple{Vararg{Cint}})
  cnt, = header...
  if ss.read_holes
    DefaultHoleSection(Vector{Cdouble}(2 * cnt))
  else
    SkipDefaultHoleSection(cnt)
  end
end

function create_default_section(ss::RegionSectionStream, header::Tuple{Vararg{Cint}})
  cnt, = header...
  if ss.read_regions === true
    DefaultRegionSection(Vector{Cdouble}(4 * cnt))
  else
    create_no_section(ss)
  end
end

function create_default_section(ss::ElementSectionStream, header::Tuple{Vararg{Cint}})
  cnt, corner_cnt, attr_cnt = header...
  elems = Vector{Cint}(corner_cnt * cnt)
  attrs = Vector{Cdouble}(attr_cnt * cnt)
  DefaultElementSection(cnt, elems, corner_cnt, attrs, attr_cnt, ss.start_index)
end

function create_default_section(ss::AreaSectionStream, header::Tuple{Vararg{Cint}})
  cnt, = header...
  DefaultAreaSection(cnt, Vector{Cdouble}(cnt))
end

function parse_header(::SectionStream, line::Vector{SubString{String}})
  (parse(Cint, line[1]))
end

function parse_header(
  ss::NodeSectionStream, line::Vector{SubString{String}}
)
  (
    parse(Cint, line[1]), parse(Cint, line[2]), parse(Cint, line[3]),
    parse(Cint, line[4])
  )
end

function parse_header(
  ss::SegmentSectionStream, line::Vector{SubString{String}}
)
  (parse(Cint, line[1]), parse(Cint, line[2]))
end

function parse_header(ss::RegionSectionStream, line::Vector{SubString{String}})
  if length(line) > 0
    (parse(Cint, line[1]))
  else
    (Cint(0))
  end
end

function parse_header(
  ss::ElementSectionStream, line::Vector{SubString{String}}
)
  (parse(Cint, line[1]), parse(Cint, line[2]), parse(Cint, line[3]))
end

function read(ss::SectionStream)
  section = create_section(ss, read_header(ss))
  read(section, get_stream(ss))
  section
end


function create_section(ss::SectionStream, header::Tuple{Vararg{Cint}})
  if header[1] === Cint(0)
    create_no_section(ss)
  else
    create_default_section(ss, header)
  end
end

function read_header(ss::SectionStream)
  parse_header(read_file_line(get_stream(ss)))
end
