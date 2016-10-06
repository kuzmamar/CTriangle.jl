abstract SectionInterface

abstract NodeSectionInterface <: SectionInterface

abstract SegmentSectionInterface <: SectionInterface

abstract HoleSectionInterface <: SectionInterface

abstract RegionSectionInterface <: SectionInterface

abstract ElementSectionInterface <: SectionInterface

abstract AreaSectionInterface <: SectionInterface

immutable NoNodeSection <: NodeSectionInterface end

type NodeSection <: NodeSectionInterface
  cnt::Cint
  points::Vector{Cdouble}
  attrs::Vector{Cdouble}
  attrCnt::Cint
  markers::Vector{Cint}
  startIndex::Cint
end

immutable NoSegmentSection <: SegmentSectionInterface end

type SegmentSection <: SegmentSectionInterface
  cnt::Cint
  segments::Vector{Cint}
  markers::Vector{Cint}
end

immutable NoHoleSection <: HoleSectionInterface end

immutable SkipHoleSection <: HoleSectionInterface
  cnt::Cint
end

type HoleSection <: HoleSectionInterface
  cnt::Cint
  holes::Vector{Cdouble}
end

immutable NoRegionSection <: RegionSectionInterface end

type RegionSection <: RegionSectionInterface
  cnt::Cint
  regions::Vector{Cdouble}
end

immutable NoAreaSection <: AreaSectionInterface end

type AreaSection <: AreaSectionInterface
  cnt::Cint
  areas::Vector{Cdouble}
end

immutable NoElementSection <: ElementSectionInterface end

type ElementSection <: ElementSectionInterface
  cnt::Cint
  elems::Vector{Cint}
  cornerCnt::Cint
  attrs::Vector{Cint}
  attrCnt::Cint
  startIndex::Cint
end

immutable Parser
  func::Function
  args::Tuple{Vararg{Cint}}
  vector::Symbol
end
