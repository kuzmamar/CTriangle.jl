abstract FileInterface

type NodeFile <: FileInterface
  nodeSection::NodeSectionInterface
end

type PolyFile <: FileInterface
  nodeSection::NodeSectionInterface
  segmentSection::SegmentSectionInterface
  holeSection::HoleSectionInterface
  regionSection::RegionSectionInterface
end

type EleFile <: FileInterface
  elementSection::ElementSectionInterface
end

type AreaFile <: FileInterface
  areaSection::AreaSectionInterface
end
