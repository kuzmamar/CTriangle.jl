type NodesHeader <: AbstractHeader
  cnt::Cint
  dim::Cint
  attrcnt::Cint
  marker::Cint
end

Base.length(h::NodesHeader) = h.cnt

hasattrs(h::NodesHeader) = h.attrcnt > 0

hasmarkers(h::NodesHeader) = h.marker != 0;

abstract AbstractNodeFile <: AbstractFile

function initio!(f::AbstractNodeFile, io::TriangulateIO)
	throw(EmptyNodeFileException())  
end

is_empty(f::AbstractNodeFile) = false

type NodeFile <: AbstractNodeFile
  points::Vector{Point}
  a::AbstractFileAttributes
  m::AbstractFileMarkers
end

function initio!(f::NodeFile, io::TriangulateIO)
  setpoints!(io, f.points)
  setpointattrs!(o.a, io)
  setpointmarkers!(o.m, io)
end

function createpointattrs(f::NodeFile, io::TriangulateIO)
	createpointattrs(f.a, io::TriangulateIO)
end

function createpointmarkers(f::NodeFile, t::Type{AbstractMarkers}, sw::Switches,
													  io::TriangulateIO)
	createpointmarkers(f.m, sw, io)
end

immutable NoNodeFile <: AbstractNodeFile end

function createpointattrs(f::NoNodeFile, io::TriangulateIO)
	NoAttributes()
end

function createpointmarkers(f::NoNodeFile, sw::Switches,
														io::TriangulateIO)
	NoMarkers()
end

is_empty(f::NoNodeFile) = true
