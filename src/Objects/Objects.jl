abstract AbstractFileAttributes

setpointattrs!(a::AbstractFileAttributes, io::TriangulateIO) = return

settriangleattrs!(a::AbstractFileAttributes, io::TriangulateIO) = return

function createpointattrs(a::AbstractFileAttributes, io::TriangulateIO)
	NoAttributes()
end

function createtriangleattrs(a::AbstractFileAttributes, io::TriangulateIO)
	NoAttributes()
end

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

function createpointattrs(a::FileAttributes, io::TriangulateIO)
	Attributes(getpointattrs(io), io.numberofpointattributes)
end

function createtriangleattrs(a::FileAttributes, io::TriangulateIO)
	Attributes(gettriangleattrs(io), io.numberoftriangleattributes)
end

immutable NoFileAttributes <: AbstractFileAttributes end

#-------------------------------------------------------------------------------

abstract AbstractFileMarkers

setpointmarkers!(m::AbstractFileMarkers, io::TriangulateIO) = return

setsegmentmarkers!(m::AbstractFileMarkers, io::TriangulateIO) = return

function createpointmarkers(m::AbstractFileMarkers, ::Type{AbstractMarkers},
													  sw::Switches, io::TriangulateIO)
	NoMarkers()
end

function createsegmentmarkers(m::AbstractFileMarkers, ::Type{AbstractMarkers},
													    sw::Switches, io::TriangulateIO)
	NoMarkers()
end

type FileMarkers <: AbstractFileMarkers
  markers::Vector{Cint}
end

function setpointmarkers!(m::FileMarkers, io::TriangulateIO)
  setpointmarkers!(io, m.markers)
end

function setsegmentmarkers!(m::FileMarkers, io::TriangulateIO)
  setsegmentmarkers!(io, m.markers)
end

function createpointmarkers(m::FileMarkers, ::Type{AbstractMarkers},
													  sw::Switches, io::TriangulateIO)
	if hasmarker(sw)
		Markes(getpointmarkers(io))
	else
		NoMarkers()
	end
end

function createsegmentmarkers(m::FileMarkers, ::Type{AbstractMarkers},
													    sw::Switches, io::TriangulateIO)
	if hasmarker(sw)
		Markes(getsegmentmarkers(io))
	else
		NoMarkers()
	end
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