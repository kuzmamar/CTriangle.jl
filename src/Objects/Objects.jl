abstract AbstractObject

abstract AbstractFileAttributes <: AbstractObject

initio!(a::AbstractFileAttributes, io::TriangulateIO) = return

type FileAttributes <: AbstractFileAttributes
  attrs::Vector{Cdouble}
  attrcnt::Cint
end

function initio!(a::FileAttributes, io::TriangulateIO)
  setpointattrs!(io, a.attrs, a.attrcnt)
end

immutable NoFileAttributes <: AbstractFileAttributes end

#-------------------------------------------------------------------------------

abstract AbstractFileMarkers <: AbstractObject

initio!(m::AbstractFileMarkers, io::TriangulateIO) = return

type FileMarkers <: AbstractFileMarkers
  markers::Vector{Cint}
end

function initio!(m::FileMarkers, io::TriangulateIO)
  setpointmarkers!(io, m.markers)
end

immutable NoFileMarkers <: AbstractFileMarkers end

#-------------------------------------------------------------------------------

abstract AbstractFileHoles <: AbstractObject

type FileHoles <: AbstractFileHoles
  holes::Vector{Point}
end

immutable NoFileHoles <: AbstractFileHoles end

#-------------------------------------------------------------------------------

abstract AbstractFileSegments <: AbstractObject

type FileSegments <: AbstractFileSegments
  segments::Vector{IndexedSegment}
  m::AbstractFileMarkers
end

immutable NoFileSegments <: AbstractFileSegments end

include("FileNodes.jl")
