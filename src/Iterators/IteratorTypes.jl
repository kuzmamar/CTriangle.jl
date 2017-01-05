abstract VectorIteratorInterface

abstract NodeIteratorInterface <: VectorIteratorInterface

type NodeIterator <: NodeIteratorInterface
  points::Vector{Cdouble}
  attrs::Vector{Cdouble}
  attrCnt::Cint
  markers::Vector{Cint}
end

immutable NoNodeIterator <: NodeIteratorInterface end

abstract ElementIteratorInterface <: VectorIteratorInterface

type ElementIterator <: ElementIteratorInterface
  nodeSection::NodeTriangulationSection
  elementSection::ElementTriangulationSection
  neighborSection::NeighborTriangulationSectionInterface
end

immutable NoElementIterator <: ElementIteratorInterface end

abstract SegmentIteratorInterface <: VectorIteratorInterface

type SegmentIterator <: SegmentIteratorInterface
  nodeSection::NodeTriangulationSection
  segmentSection::SegmentTriangulationSection
end

immutable NoSegmentIterator <: SegmentIteratorInterface end

abstract PointIteratorInterface <: VectorIteratorInterface

immutable NoPointIterator <: PointIteratorInterface end

type PointIterator <: PointIteratorInterface
  points::Vector{Cdouble}
end

abstract EdgeIteratorInterface <: VectorIteratorInterface

immutable NoEdgeIterator <: EdgeIteratorInterface end

type EdgeIterator <: EdgeIteratorInterface
  nodeSection::NodeTriangulationSection
  edgeSection::EdgeTriangulationSection
end

abstract RegionIteratorInterface <: VectorIteratorInterface

immutable NoRegionIterator <: RegionIteratorInterface end

type RegionIterator <: RegionIteratorInterface
  regions::Vector{Cdouble}
end
