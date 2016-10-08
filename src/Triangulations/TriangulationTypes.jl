abstract TriangulationInterface

type DelaunayTriangulation <: TriangulationInterface
  nodeSection::NodeTriangulationSection
  segmentSection::SegmentTriangulationSectionInterface
  elementSection::ElementTriangulationSectionInterface
  edgeSection::EdgeTriangulationSectionInterface
  neighborSection::NeighborTriangulationSectionInterface
end

type ConstrainedDelaunayTriangulation <: TriangulationInterface
  nodeSection::NodeTriangulationSection
  segmentSection::SegmentTriangulationSectionInterface
  holeSection::HoleTriangulationSectionInterface
  regionSection::RegionTriangulationSectionInterface
  elementSection::ElementTriangulationSectionInterface
  edgeSection::EdgeTriangulationSectionInterface
  neighborSection::NeighborTriangulationSectionInterface
end

type DelaunayRefinementTriangulation <: TriangulationInterface
  nodeSection::NodeTriangulationSection
  segmentSection::SegmentTriangulationSectionInterface
  elementSection::ElementTriangulationSectionInterface
  areaSection::AreaTriangulationSectionInterface
  edgeSection::EdgeTriangulationSectionInterface
  neighborSection::NeighborTriangulationSectionInterface
end

type ConstrainedDelaunayRefinementTriangulation <: TriangulationInterface
  nodeSection::NodeTriangulationSection
  segmentSection::SegmentTriangulationSectionInterface
  holeSection::HoleTriangulationSectionInterface
  elementSection::ElementTriangulationSectionInterface
  areaSection::AreaTriangulationSectionInterface
  edgeSection::EdgeTriangulationSectionInterface
  neighborSection::NeighborTriangulationSectionInterface
end
