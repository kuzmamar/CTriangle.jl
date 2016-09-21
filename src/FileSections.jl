type Parser
  func::Function
  args::Vector{Cint}
end

abstract FileSection

function read(fs::FileSection, is::IOStream, parsers::Vector{Parser})
  cnt = get_count(fs)
  for i in Cint(1):cnt
    line = read_file_line(is)
    for parser in parsers
      parser.func(fs, line, i, parser.args)
    end
  end
end

abstract NodeSection <: FileSection

abstract SegmentSection <: FileSection

abstract HoleSection <: FileSection

abstract RegionSection <: FileSection

immutable NoNodeSection <: NodeSection

type DefaultNodeSection <: NodeSection
  cnt::Cint
  points::Vector{Cint}
  attrs::Vector{Cdouble}
  attr_cnt::Cint
  markers::Vector{Cint}
end

read(fs::NodeSection, is::IOStream) = return

function parse_points(fs::DefaultNodeSection, line, line_num::Cint, pos::Vector{Cint})
  
end

function read(fs::DefaultNodeSection, is::IOStream)
  has_markers = size(fs.markers) > 0
  has_attrs = f.attr_cnt > 0
  attrs_end = Cint(4 + fs.attr_cnt)

  if has_attrs == true && has_markers == true
    read(fs, is, [
      Parser(parse_points, Vector{Cint}[]),
      Parser(parse_attrs, Vector{Cint}[Cint(4), attrs_end]),
      Parser(parse_marker, Vector{Cint}[attrs_end + 1])
    ])
  elseif has_attrs == true
    read(fs, is, [
      Parser(parse_points, Vector{Cint}[]),
      Parser(parse_attrs, Vector{Cint}[Cint(4), attrs_end])
    ])
  elseif has_markers == true
    read(fs, is, [
      Parser(parse_points, Vector{Cint}[]),
      Parser(parse_markers, Vector{Cint}[Cint(4)])
    ])
  else
    read(fs, is, [
      Parser(parse_points, Vector{Cint}[])
    ])
  end
end

type DefaultSegmentSection <: SegmentSection
  segments::Vector{Cint}
  markers::Vector{Cint}
end

immutable NoSegmentSection <: SegmentSection end

type DefaultHoleSection <: HoleSection
  holes::Vector{Cdouble}
end

immutable NoHoleSection <: HoleSection end


type DefaultRegionSection <: RegionSection
  regions::Vector{Cdouble}
end

immutable NoRegionSection <: RegionSection end
