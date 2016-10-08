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
