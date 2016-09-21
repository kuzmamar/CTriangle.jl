abstract FileSection

abstract NodeSection <: FileSection

type DefaultNodeSection <: NodeSection
  points::Vector{Cdouble}
  markers::Vector{Cint}
  attrs::Vector{Cdouble}
end

type NoNodeSection <: NodeSection end


type SegmentSection <: FileSection
  segments::Vector{Cint}
  markers::Vector{Cint}
end

type NoSegmentSection <: FileSection end


type HoleSection <: FileSection
  points::Vector{Cdouble}
end

type NoHoleSection <: FileSection end

type RegionSection <: FileSection

end
