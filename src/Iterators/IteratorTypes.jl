abstract VectorIteratorInterface

immutable NodeIterator <: VectorIteratorInterface
  nodeSection::NodeTriangulationSection
end

immutable ElementIterator <: VectorIteratorInterface
  nodeSection::NodeTriangulationSection
  elementSection::ElementTriangulationSectionInterface
end

immutable SegmentIterator <: VectorIteratorInterface
  nodeSection::NodeTriangulationSection
  segmentSection::SegmentTriangulationSectionInterface
end

immutable HoleIterator <: VectorIteratorInterface
  holeSection::HoleTriangulationSectionInterface
end

immutable EdgeIterator <: VectorIteratorInterface
  nodeSection::NodeTriangulationSection
  edgeSection::EdgeTriangulationSectionInterface
end

immutable RegionIterator <: VectorIteratorInterface
  regionSection::RegionTriangulationSectionInterface
end
