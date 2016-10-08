abstract VectorIteratorInterface

type NodeIterator <: VectorIteratorInterface
  points::Vector{Cdouble}
  attrs::Vector{Cdouble}
  attrCnt::Cint
  markers::Vector{Cint}
end
