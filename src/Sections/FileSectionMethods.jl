Base.start(::FileSectionInterface) = Cint(1)

Base.next(::FileSectionInterface, state::Cint) = (state, state + Cint(1))

Base.done(section::FileSectionInterface, state::Cint) = state > length(section)

Base.eltype(section::FileSectionInterface) = Cint

Base.length(section::FileSectionInterface) = Cint(0)

Base.length(section::NodeFileSection) = section.cnt

Base.length(section::SegmentFileSection) = section.cnt

Base.length(section::SkipHoleFileSection) = section.cnt

Base.length(section::HoleFileSection) = section.cnt

Base.length(section::RegionFileSection) = section.cnt

Base.length(section::ElementFileSection) = section.cnt

Base.length(section::AreaFileSection) = section.cnt

isEmpty(::NodeFileSectionInterface) = true

isEmpty(::NodeFileSection) = false

getStartIndex(::NodeFileSectionInterface) = Cint(1)

getStartIndex(section::NodeFileSection) = section.startIndex

function applyParsers(
  section::FileSectionInterface, line::Vector{SubString{String}},
  parsers::Vector{Parser}, index::Cint
)
  for parser in parsers
    vector = parser.vector
    args = parser.args
    parser.func(getfield(section, vector), line, index, args...)
  end
end

function parseLine(
  section::FileSectionInterface, line::Vector{SubString{String}},
  parsers::Vector{Parser}, index::Cint
)
  applyParsers(section, line, parsers, index)
end

function parseLine(
  section::SkipHoleFileSection, line::Vector{SubString{String}},
  parsers::Vector{Parser}, index::Cint
)
end

function parseLine(
  section::NodeFileSection, line::Vector{SubString{String}},
  parsers::Vector{Parser}, index::Cint
)
  if index === Cint(1)
    section.startIndex = parse(Cint, line[1])
  end
  applyParsers(section, line, parsers, index)
end

Base.read(::FileSectionInterface, ::IO) = return

function Base.read(section::FileSectionInterface, fileStream::IO, parsers::Vector{Parser})
  for index in section
    parseLine(section, readFileLine(fileStream), parsers, index)
  end
end

function Base.read(section::NodeFileSection, fileStream::IO)
  hasMarkers = length(section.markers) > 0
  hasAttrs = section.attrCnt > Cint(0)
  if hasAttrs == true && hasMarkers == true
    read(section, fileStream, [
      Parser(parsePoints, (Cint(2), ), :points),
      Parser(parseAttrs, (Cint(4), section.attrCnt), :attrs),
      Parser(parseMarkers, (Cint(4 + section.attrCnt), ), :markers)
    ])
  elseif hasAttrs == true
    read(section, fileStream, [
      Parser(parsePoints, (Cint(2), ), :points),
      Parser(parseAttrs, (Cint(4), section.attrCnt), :attrs)
    ])
  elseif hasMarkers == true
    read(section, fileStream, [
      Parser(parsePoints, (Cint(2), ), :points),
      Parser(parseMarkers, (Cint(4), ), :markers)
    ])
  else
    read(section, fileStream, [
      Parser(parsePoints, (Cint(2), ), :points)
    ])
  end
end

function Base.read(section::SegmentFileSection, fileStream::IO)
  if length(section.markers) > 0
    read(section, fileStream, [
      Parser(parseSegments, (Cint(2), section.startIndex), :segments),
      Parser(parseMarkers, (Cint(4), ), :markers)
    ])
  else
    read(section, fileStream, [
      Parser(parseSegments, (Cint(2), section.startIndex), :segments)
    ])
  end
end

function Base.read(section::HoleFileSection, fileStream::IO)
  read(section, fileStream, [
    Parser(parseHoles, (Cint(2), ), :holes)
  ])
end

function Base.read(section::SkipHoleFileSection, fileStream::IO)
  read(section, fileStream, Parser[])
end

function Base.read(section::RegionFileSection, fileStream::IO)
  read(section, fileStream, [
    Parser(parseRegions, (Cint(2), ), :regions)
  ])
end

function Base.read(section::ElementFileSection, fileStream::IO)
  if section.attrCnt > Cint(0)
    read(section, fileStream, [
      Parser(parseElems, (Cint(2), section.cornerCnt, section.startIndex), :elems),
      Parser(parseAttrs, (Cint(2) + section.cornerCnt, section.attrCnt), :attrs)
    ])
  else
    read(section, fileStream, [
      Parser(parseElems, (Cint(2), section.cornerCnt, section.startIndex), :elems)
    ])
  end
end

function Base.read(section::AreaFileSection, fileStream::IO)
  read(section, fileStream, [
    Parser(parseAreas, (Cint(2), ), :areas)
  ])
end

init(::FileSectionInterface, ::InputTriangulateIO) = return

function init(section::NodeFileSection, ioIn::InputTriangulateIO)
  setPoints(ioIn, section.points)
  setPointAttrs(ioIn, section.attrs, section.attrCnt)
  setPointMarkers(ioIn, section.markers)
end

function init(section::SegmentFileSection, ioIn::InputTriangulateIO)
  setSegments(ioIn, section.segments)
  setSegmentMarkers(ioIn, section.markers)
end

function init(section::HoleFileSection, ioIn::InputTriangulateIO)
  setHoles(ioIn, section.holes)
end

function init(section::RegionFileSection, ioIn::InputTriangulateIO)
  setRegions(ioIn, section.regions)
end

function init(section::ElementFileSection, ioIn::InputTriangulateIO)
  setElements(ioIn, section.elems, section.cornerCnt)
  setElementAttrs(ioIn, section.attrs, section.attrCnt)
end

function init(section::AreaFileSection, ioIn::InputTriangulateIO)
  setAreas(ioIn, section.areas)
end
