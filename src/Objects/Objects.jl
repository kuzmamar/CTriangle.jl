abstract AbstractFileAttributes

setpointattrs!(a::AbstractFileAttributes, io::TriangulateIO) = return

settriangleattrs!(a::AbstractFileAttributes, io::TriangulateIO) = return

type FileAttributes <: AbstractFileAttributes
  attrs::Vector{Cdouble}
  attrcnt::Cint
end

function setpointattrs!(a::FileAttributes, io::TriangulateIO)
  setpointattrs!(io, a.attrs, a.attrcnt)
end

function settriangleattrs!(a::FileAttributes, io::TriangulateIO)
  settriangleattrs!(io, a.attrs, a.attrcnt)
end

immutable NoFileAttributes <: AbstractFileAttributes end

#-------------------------------------------------------------------------------

abstract AbstractFileMarkers

setpointmarkers!(m::AbstractFileMarkers, io::TriangulateIO) = return

setsegmentmarkers!(m::AbstractFileMarkers, io::TriangulateIO) = return

type FileMarkers <: AbstractFileMarkers
  markers::Vector{Cint}
end

function setpointmarkers!(m::FileMarkers, io::TriangulateIO)
  setpointmarkers!(io, m.markers)
end

function setsegmentmarkers!(m::FileMarkers, io::TriangulateIO)
  setsegmentmarkers!(io, m.markers)
end

immutable NoFileMarkers <: AbstractFileMarkers end

#-------------------------------------------------------------------------------

abstract AbstractFileHoles

setholes!(h::AbstractFileHoles, io::TriangulateIO) = return

type FileHoles <: AbstractFileHoles
  holes::Vector{Point}
end

function setholes!(h::FileHoles, io::TriangulateIO)
  setholes!(io, h.holes)
end

immutable NoFileHoles <: AbstractFileHoles end

#-------------------------------------------------------------------------------

abstract AbstractFileSegments

type FileSegments <: AbstractFileSegments
  segments::Vector{IndexedSegment}
  m::AbstractFileMarkers
end

setsegments!(s::AbstractFileSegments, io::TriangulateIO) = return

function setsegments!(s::FileSegments, io::TriangulateIO)
  setsegments!(io, s.segments)
  setsegmentmarkers!(io, s.m)
end

immutable NoFileSegments <: AbstractFileSegments end