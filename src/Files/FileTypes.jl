abstract FileInterface

type NodeFile <: FileInterface
  nodeSection::NodeFileSectionInterface
end

type PolyFile <: FileInterface
  nodeSection::NodeFileSectionInterface
  segmentSection::SegmentFileSectionInterface
  holeSection::HoleFileSectionInterface
  regionSection::RegionFileSectionInterface
end

type EleFile <: FileInterface
  elementSection::ElementFileSectionInterface
end

type AreaFile <: FileInterface
  areaSection::AreaFileSectionInterface
end
