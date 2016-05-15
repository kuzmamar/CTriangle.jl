type NodesHeader <: AbstractHeader
  cnt::Cint
  dim::Cint
  attrcnt::Cint
  marker::Cint
end

Base.length(h::NodesHeader) = h.cnt

hasattrs(h::NodesHeader) = h.attrcnt > 0

hasmarkers(h::NodesHeader) = h.marker != 0

abstract AbstractNodeFile <: AbstractFile

type NodeFile <: AbstractNodeFile
  points::Vector{Point}
  a::AbstractAttributes
  m::AbstractMarkers
end

create(f::NodeFile) = FileNodes(f.points, f.a, f.m)

immutable NoNodeFile <: AbstractNodeFile end

create(f::NoNodeFile) = NoFileNodes()
