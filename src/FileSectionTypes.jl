abstract FileSection

abstract NodeSection <: FileSection

abstract SegmentSection <: FileSection

abstract HoleSection <: FileSection

abstract RegionSection <: FileSection

immutable NoNodeSection <: NodeSection end

type DefaultNodeSection <: NodeSection
  cnt::Cint
  points::Vector{Cdouble}
  attrs::Vector{Cdouble}
  attr_cnt::Cint
  markers::Vector{Cint}
end

immutable NoSegmentSection <: SegmentSection end

type DefaultSegmentSection <: SegmentSection
  segments::Vector{Cint}
  markers::Vector{Cint}
end

immutable NoHoleSection <: HoleSection end

type DefaultHoleSection <: HoleSection
  holes::Vector{Cdouble}
end

immutable NoRegionSection <: RegionSection end

type DefaultRegionSection <: RegionSection
  regions::Vector{Cdouble}
end

type Parser
  func::Function
  args::Tuple{Cint}
  vector::Symbol
end
