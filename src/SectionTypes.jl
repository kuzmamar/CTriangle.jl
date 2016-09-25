abstract Section

abstract NodeSection <: Section

abstract SegmentSection <: Section

abstract HoleSection <: Section

abstract RegionSection <: Section

abstract ElementSection <: Section

abstract AreaSection <: Section

immutable NoNodeSection <: NodeSection end

type DefaultNodeSection <: NodeSection
  cnt::Cint
  points::Vector{Cdouble}
  attrs::Vector{Cdouble}
  attr_cnt::Cint
  markers::Vector{Cint}
  start_index::Cint
end

immutable NoSegmentSection <: SegmentSection end

type DefaultSegmentSection <: SegmentSection
  cnt::Cint
  segments::Vector{Cint}
  markers::Vector{Cint}
  first_index::Cint
end

immutable NoHoleSection <: HoleSection end

immutable SkipDefaultHoleSection <: HoleSection
  cnt::Cint
end

type DefaultHoleSection <: HoleSection
  cnt::Cint
  holes::Vector{Cdouble}
end

immutable NoRegionSection <: RegionSection end

type DefaultRegionSection <: RegionSection
  cnt::Cint
  regions::Vector{Cdouble}
end

immutable NoAreaSection <: AreaSection end

type DefaultAreaSection <: AreaSection
  cnt::Cint
  areas::Vector{Cdouble}
end

immutable NoElementSection <: ElementSection end

type DefaultElementSection <: ElementSection
  cnt::Cint
  elems::Vector{Cint}
  corner_cnt::Cint
  attrs::Vector{Cint}
  attr_cnt::Cint
  first_index::Cint
end

immutable Parser <: Parser
  func::Function
  args::Tuple{Vararg{Cint}}
  vector::Symbol
end
