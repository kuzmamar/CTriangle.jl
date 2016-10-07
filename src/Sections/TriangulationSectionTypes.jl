type NodeTriangulationSection
  points::Vector{Cdouble}
  attrs::Vector{Cdouble}
  attrCnt::Cint
  markers::Vector{Cint}
end

abstract SegmentTriangulationSectionInterface

immutable NoSegmentTriangulationSection <: SegmentTriangulationSectionInterface
end

type SegmentTriangulationSection <: SegmentTriangulationSectionInterface
  segments::Vector{Cint}
  markers::Vector{Cint}
end

abstract HoleTriangulationSectionInterface

immutable NoHoleTriangulationSection <: HoleTriangulationSectionInterface end

type HoleTriangulationSection <: HoleTriangulationSectionInterface
  holes::Vector{Cdouble}
end

abstract RegionTriangulationSectionInterface

immutable NoRegionTriangulationSection <: RegionTriangulationSectionInterface
end

type RegionTriangulationSection <: RegionTriangulationSectionInterface
  regions::Vector{Cdouble}
end

abstract ElementTriangulationSectionInterface

immutable NoElementTriangulationSection <: ElementTriangulationSectionInterface
end

type ElementTriangulationSection <: ElementTriangulationSectionInterface
  elems::Vector{Cint}
  cornerCnt::Cint
  attrs::Vector{Cdouble}
  attrCnt::Cint
end

abstract AreaTriangulationSectionInterface

immutable NoAreaTriangulationSection <: AreaTriangulationSectionInterface end

type AreaTriangulationSection <: AreaTriangulationSectionInterface
  areas::Vector{Cdouble}
end

abstract EdgeTriangulationSectionInterface

immutable NoEdgeTriangulationSection <: EdgeTriangulationSectionInterface end

type EdgeTriangulationSection <: EdgeTriangulationSectionInterface
  edges::Vector{Cint}
  markers::Vector{Cint}
end

abstract NeighborTriangulationSectionInterface

immutable NoNeighborTriangulationSection <: NeighborTriangulationSectionInterface
end

type NeighborTriangulationSection <: NeighborTriangulationSectionInterface
  neighbors::Vector{Cint}
end
