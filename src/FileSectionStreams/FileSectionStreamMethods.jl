getStream(sectionStream::FileSectionStreamInterface) = sectionStream.fileStream

createNoFileSection(::FileSectionStreamInterface) = error("Implement createNoFileSection method")

createNoFileSection(::NodeFileSectionStream) = NoNodeFileSection()

createNoFileSection(::SegmentFileSectionStream) = NoSegmentFileSection()

createNoFileSection(::HoleFileSectionStream) = NoHoleFileSection()

createNoFileSection(::RegionFileSectionStream) = NoRegionFileSection()

createNoFileSection(::ElementFileSectionStream) = NoElementFileSection()

createNoFileSection(::AreaFileSectionStream) = NoAreaFileSection()

function createDefaultFileSection(::FileSectionStreamInterface, ::Tuple{Vararg{Cint}})
  error("Implement createDefaultFileSection method")
end

function createDefaultFileSection(sectionStream::NodeFileSectionStream, header::Tuple{Vararg{Cint}})
  cnt, dim, attrCnt, marker = header
  points = Vector{Cdouble}(2 * cnt)
  attrs = Vector{Cdouble}(cnt * attrCnt)
  markers = createMarkers(marker, cnt)
  NodeFileSection(cnt, points, attrs, attrCnt, markers, Cint(1))
end

function createDefaultFileSection(sectionStream::SegmentFileSectionStream, header::Tuple{Vararg{Cint}})
  cnt, marker = header
  segments = Vector{Cint}(2 * cnt)
  markers = createMarkers(marker, cnt)
  SegmentFileSection(cnt, segments, markers, sectionStream.startIndex)
end

function createDefaultFileSection(sectionStream::HoleFileSectionStream, header::Tuple{Vararg{Cint}})
  cnt, = header
  if sectionStream.useHoles
    HoleFileSection(cnt, Vector{Cdouble}(2 * cnt))
  else
    SkipHoleFileSection(cnt)
  end
end

function createDefaultFileSection(sectionStream::RegionFileSectionStream, header::Tuple{Vararg{Cint}})
  cnt, = header
  if sectionStream.useRegions === true
    RegionFileSection(cnt, Vector{Cdouble}(4 * cnt))
  else
    createNoFileSection(sectionStream)
  end
end

function createDefaultFileSection(sectionStream::ElementFileSectionStream, header::Tuple{Vararg{Cint}})
  cnt, cornerCnt, attrCnt = header
  elems = Vector{Cint}(cornerCnt * cnt)
  attrs = Vector{Cdouble}(attrCnt * cnt)
  ElementFileSection(cnt, elems, cornerCnt, attrs, attrCnt, sectionStream.startIndex)
end

function createDefaultFileSection(sectionStream::AreaFileSectionStream, header::Tuple{Vararg{Cint}})
  cnt, = header
  AreaFileSection(cnt, Vector{Cdouble}(cnt))
end

function parseHeader(::FileSectionStreamInterface, line::Vector{SubString{String}})
  (parse(Cint, line[1]), )
end

function parseHeader(
  sectionStream::NodeFileSectionStream, line::Vector{SubString{String}}
)
  (
    parse(Cint, line[1]), parse(Cint, line[2]), parse(Cint, line[3]),
    parse(Cint, line[4])
  )
end

function parseHeader(
  sectionStream::SegmentFileSectionStream, line::Vector{SubString{String}}
)
  (parse(Cint, line[1]), parse(Cint, line[2]))
end

function parseHeader(sectionStream::RegionFileSectionStream,
  line::Vector{SubString{String}}
)
  if length(line) > 0
    (parse(Cint, line[1]), )
  else
    (Cint(0), )
  end
end

function parseHeader(
  sectionStream::ElementFileSectionStream, line::Vector{SubString{String}}
)
  (parse(Cint, line[1]), parse(Cint, line[2]), parse(Cint, line[3]))
end

function Base.read(sectionStream::FileSectionStreamInterface)
  section = createFileSection(sectionStream, readHeader(sectionStream))
  read(section, getStream(sectionStream))
  section
end


function createFileSection(sectionStream::FileSectionStreamInterface,
  header::Tuple{Vararg{Cint}}
)
  if header[1] === Cint(0)
    createNoFileSection(sectionStream)
  else
    createDefaultFileSection(sectionStream, header)
  end
end

function readHeader(sectionStream::FileSectionStreamInterface)
  parseHeader(sectionStream, readFileLine(getStream(sectionStream)))
end
