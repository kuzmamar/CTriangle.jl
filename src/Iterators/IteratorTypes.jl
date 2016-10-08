abstract VectorIteratorInterface

type NodeIterator <: VectorIteratorInterface
  points::Vector{Cdouble}
  attrs::Vector{Cdouble}
  attrCnt::Cint
  markers::Vector{Cint}
end

type ElementIterator <: VectorIteratorInterface
  nodeSection::NodeTriangulationSection
  elementSection::ElementTriangulationSection
  neighborSection::NeighborTriangulationSectionInterface
end

type SegmentIterator <: VectorIteratorInterface
  nodeSection::NodeTriangulationSection
  segmentSection::SegmentTriangulationSection
end

type PointIterator <: VectorIteratorInterface
  points::Vector{Cdouble}
end

type EdgeIterator <: VectorIteratorInterface
  nodeSection::NodeTriangulationSection
  edgeSection::EdgeTriangulationSection
end
