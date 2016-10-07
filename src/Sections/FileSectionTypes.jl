abstract FileSectionInterface

abstract NodeFileSectionInterface <: FileSectionInterface

abstract SegmentFileSectionInterface <: FileSectionInterface

abstract HoleFileSectionInterface <: FileSectionInterface

abstract RegionFileSectionInterface <: FileSectionInterface

abstract ElementFileSectionInterface <: FileSectionInterface

abstract AreaFileSectionInterface <: FileSectionInterface

immutable NoNodeFileSection <: NodeFileSectionInterface end

type NodeFileSection <: NodeFileSectionInterface
  cnt::Cint
  points::Vector{Cdouble}
  attrs::Vector{Cdouble}
  attrCnt::Cint
  markers::Vector{Cint}
  startIndex::Cint
end

immutable NoSegmentFileSection <: SegmentFileSectionInterface end

type SegmentFileSection <: SegmentFileSectionInterface
  cnt::Cint
  segments::Vector{Cint}
  markers::Vector{Cint}
  startIndex::Cint
end

immutable NoHoleFileSection <: HoleFileSectionInterface end

immutable SkipHoleFileSection <: HoleFileSectionInterface
  cnt::Cint
end

type HoleFileSection <: HoleFileSectionInterface
  cnt::Cint
  holes::Vector{Cdouble}
end

immutable NoRegionFileSection <: RegionFileSectionInterface end

type RegionFileSection <: RegionFileSectionInterface
  cnt::Cint
  regions::Vector{Cdouble}
end

immutable NoAreaFileSection <: AreaFileSectionInterface end

type AreaFileSection <: AreaFileSectionInterface
  cnt::Cint
  areas::Vector{Cdouble}
end

immutable NoElementFileSection <: ElementFileSectionInterface end

type ElementFileSection <: ElementFileSectionInterface
  cnt::Cint
  elems::Vector{Cint}
  cornerCnt::Cint
  attrs::Vector{Cdouble}
  attrCnt::Cint
  startIndex::Cint
end

immutable Parser
  func::Function
  args::Tuple{Vararg{Cint}}
  vector::Symbol
end
