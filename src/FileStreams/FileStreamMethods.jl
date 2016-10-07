Base.close(fileStream::FileStreamInterface) = close(fileStream.fileStream)

Base.read(::FileStreamInterface) = error("Implement method read")

function Base.read(fileStream::NodeStream)
  NodeFile(read(NodeFileSectionStream(fileStream.fileStream)))
end

function Base.read(fileStream::PolyStream)
  nodeSection = read(NodeFileSectionStream(fileStream.fileStream))
  if isEmpty(nodeSection) == true
    nodeFile = read(fileStream.nodeHandler)
    nodeSection = nodeFile.nodeSection
  end
  if isEmpty(nodeSection) == true
    segmentSection = NoSegmentFileSection()
    holeSection = NoHoleFileSection()
    regionSection = NoRegionFileSection()
  else
    segmentSection = read(SegmentFileSectionStream(fileStream.fileStream, getStartIndex(nodeSection)))
    holeSection = read(HoleFileSectionStream(fileStream.fileStream, fileStream.useHoles))
    regionSection = read(RegionFileSectionStream(fileStream.fileStream, fileStream.useRegions))
  end
  PolyFile(nodeSection, segmentSection, holeSection, regionSection)
end

function Base.read(fileStream::EleStream)
  EleFile(read(ElementFileSectionStream(fileStream.fileStream, fileStream.startIndex)))
end

function Base.read(fileStream::AreaStream)
  AreaFile(read(AreaFileSectionStream(fileStream.fileStream)))
end
