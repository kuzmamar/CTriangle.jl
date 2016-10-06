getStream(sectionStream::SectionStreamInterface) = sectionStream.fileStream

createNoSection(::SectionStreamInterface) = error("Implement createNoSection method")

createNoSection(::NodeSectionStream) = NoNodeSection()

createNoSection(::SegmentSectionStream) = NoSegmentSection()

createNoSection(::HoleSectionStream) = NoHoleSection()

createNoSection(::RegionSectionStream) = NoRegionSection()

createNoSection(::ElementSectionStream) = NoElementSection()

createNoSection(::AreaSectionStream) = NoAreaSection()

function createDefaultSection(::SectionStreamInterface, ::Tuple{Vararg{Cint}})
  error("Implement createDefaultSection method")
end

function createDefaultSection(sectionStream::NodeSectionStream, header::Tuple{Vararg{Cint}})
  cnt, dim, attrCnt, marker = header
  points = Vector{Cdouble}(2 * cnt)
  attrs = Vector{Cdouble}(cnt * attrCnt)
  markers = createMarkers(marker, cnt)
  NodeSection(cnt, points, attrs, attrCnt, markers, Cint(1))
end

function createDefaultSection(sectionStream::SegmentSectionStream, header::Tuple{Vararg{Cint}})
  cnt, marker = header
  segments = Vector{Cint}(2 * cnt)
  markers = createMarkers(marker, cnt)
  SegmentSection(cnt, segments, markers, sectionStream.startIndex)
end

function createDefaultSection(sectionStream::HoleSectionStream, header::Tuple{Vararg{Cint}})
  cnt, = header
  if sectionStream.useHoles
    HoleSection(Vector{Cdouble}(2 * cnt))
  else
    SkipDefaultHoleSection(cnt)
  end
end

function createDefaultSection(sectionStream::RegionSectionStream, header::Tuple{Vararg{Cint}})
  cnt, = header
  if sectionStream.useRegions === true
    RegionSection(Vector{Cdouble}(4 * cnt))
  else
    createNoSection(sectionStream)
  end
end

function createDefaultSection(sectionStream::ElementSectionStream, header::Tuple{Vararg{Cint}})
  cnt, cornerCnt, attrCnt = header
  elems = Vector{Cint}(cornerCnt * cnt)
  attrs = Vector{Cdouble}(attrCnt * cnt)
  ElementSection(cnt, elems, cornerCnt, attrs, attrCnt, sectionStream.startIndex)
end

function createDefaultSection(sectionStream::AreaSectionStream, header::Tuple{Vararg{Cint}})
  cnt, = header
  AreaSection(cnt, Vector{Cdouble}(cnt))
end

function parseHeader(::SectionStreamInterface, line::Vector{SubString{String}})
  (parse(Cint, line[1]))
end

function parseHeader(
  sectionStream::NodeSectionStream, line::Vector{SubString{String}}
)
  (
    parse(Cint, line[1]), parse(Cint, line[2]), parse(Cint, line[3]),
    parse(Cint, line[4])
  )
end

function parseHeader(
  sectionStream::SegmentSectionStream, line::Vector{SubString{String}}
)
  (parse(Cint, line[1]), parse(Cint, line[2]))
end

function parseHeader(sectionStream::RegionSectionStream,
  line::Vector{SubString{String}}
)
  if length(line) > 0
    (parse(Cint, line[1]))
  else
    (Cint(0), )
  end
end

function parseHeader(
  sectionStream::ElementSectionStream, line::Vector{SubString{String}}
)
  (parse(Cint, line[1]), parse(Cint, line[2]), parse(Cint, line[3]))
end

function Base.read(sectionStream::SectionStreamInterface)
  section = createSection(sectionStream, readHeader(sectionStream))
  read(section, getStream(sectionStream))
  section
end


function createSection(sectionStream::SectionStreamInterface,
  header::Tuple{Vararg{Cint}}
)
  if header[1] === Cint(0)
    createNoSection(sectionStream)
  else
    createDefaultSection(sectionStream, header)
  end
end

function readHeader(sectionStream::SectionStreamInterface)
  parseHeader(sectionStream, readFileLine(getStream(sectionStream)))
end
