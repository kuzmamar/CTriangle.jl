Base.start(::SectionInterface) = Cint(1)

Base.next(::SectionInterface, state::Cint) = (state, state + Cint(1))

Base.done(section::SectionInterface, state::Cint) = state > length(section)

Base.eltype(section::SectionInterface) = Cint

Base.length(section::SectionInterface) = Cint(0)

Base.length(section::NodeSection) = section.cnt

Base.length(section::SegmentSection) = section.cnt

Base.length(section::SkipHoleSection) = section.cnt

Base.length(section::HoleSection) = section.cnt

Base.length(section::RegionSection) = section.cnt

Base.length(section::ElementSection) = section.cnt

Base.length(section::AreaSection) = section.cnt

isEmpty(::NodeSectionInterface) = true

isEmpty(::NodeSection) = false

getStartIndex(::NodeSectionInterface) = Cint(1)

getStartIndex(section::NodeSection) = section.startIndex

function applyParsers(
  section::SectionInterface, line::Vector{SubString{String}},
  parsers::Vector{Parser}, index::Cint
)
  for parser in parsers
    vector = parser.vector
    args = parser.args
    parser.func(getfield(section, vector), line, index, args...)
  end
end

function parseLine(
  section::SectionInterface, line::Vector{SubString{String}},
  parsers::Vector{Parser}, index::Cint
)
  applyParsers(section, line, parsers, index)
end

function parseLine(
  section::SkipHoleSection, line::Vector{SubString{String}},
  parsers::Vector{Parser}, index::Cint
)
end

function parseLine(
  section::NodeSection, line::Vector{SubString{String}},
  parsers::Vector{Parser}, index::Cint
)
  if index === Cint(1)
    section.startIndex = parse(Cint, line[1])
  end
  applyParsers(section, line, parsers, index)
end

Base.read(::SectionInterface, ::IO) = return

function Base.read(section::SectionInterface, fileStream::IO, parsers::Vector{Parser})
  for index in section
    parseLine(section, readFileLine(fileStream), parsers, index)
  end
end

function Base.read(section::NodeSection, fileStream::IO)
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

function Base.read(section::SegmentSection, fileStream::IO)
  if length(s.markers) > 0
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

function Base.read(section::HoleSection, fileStream::IO)
  read(section, fileStream, [
    Parser(parseHoles, (Cint(2), ), :holes)
  ])
end

function Base.read(section::SkipHoleSection, fileStream::IO)
  read(section, fileStream, Parser[])
end

function Base.read(section::RegionSection, fileStream::IO)
  read(section, fileStream, [
    Parser(parseRegions, (Cint(2), ), :regions)
  ])
end

function Base.read(section::ElementSection, fileStream::IO)
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

function Base.read(section::AreaSection, fileStream::IO)
  read(section, fileStream, [
    Parser(parseAreas, (Cint(2), ), :areas)
  ])
end
