# Represents a Node with a possible boundary marker and attributes.
type Node
  a::Point
  i::AbstractAttributeIterator
  marker::Cint
end

getattributes(n::Node) = n.i

getpoint(n::Node) = n.a

getmarker(n::Node) = n.marker

# Represents a Segment with two ending points and possible boundary marker.
type Segment
  a::Node
  b::Node
  marker::Cint
end

getmarker(s::Segment) = s.marker

getfirstnode(s::Segment) = s.a

getsecondnode(s::Segment) = s.b

# Represents an Edge with two ending points and possible boundary marker.
type Edge
  a::Node
  b::Node
  marker::Cint
end

getmarker(s::Edge) = s.marker

getfirstnode(s::Edge) = s.a

getsecondnode(s::Edge) = s.b

abstract AbstractAttributes <: AbstractIterable{AbstractAttributeIterator}

function Base.getindex(i::AbstractAttributes, index::Integer)
  create(NoAttributeIterator)
end

type Attributes <: AbstractAttributes
  attrs::Vector{Cdouble}
  attrcnt::Cint
end

function Base.getindex(i::Attributes, index::Integer)
  create(AttributeIterator, i.attrs, i.attrcnt, index)
end

Base.length(i::Attributes) = getlength(i.attrs, i.attrcnt)

immutable NoAttributes <: AbstractAttributes end

#-------------------------------------------------------------------------------

abstract AbstractMarkers <: AbstractIterable{Cint}

Base.getindex(i::AbstractMarkers, index::Integer) = Cint(0)

type Markers <: AbstractMarkers
  markers::Vector{Cint}
end

Base.getindex(i::Markers, index::Integer) = i.markers[index]

immutable NoMarkers <: AbstractMarkers end

#-------------------------------------------------------------------------------

type Nodes <: AbstractIterable{Node}
  points::Vector{Point}
  a::AbstractAttributes
  m::AbstractMarkers
end

function Base.getindex(i::Nodes, index::Integer)
  Node(i.points[index], i.a[index], i.m[index])
end

Base.length(i::Nodes) = length(i.points)

#-------------------------------------------------------------------------------

abstract AbstractNeighbors <: AbstractIterable{IndexedTriangleNeighbors}

type Neighbors <: AbstractNeighbors
  neighbors::Vector{IndexedTriangleNeighbors}
end

Base.getindex(i::Neighbors, index::Integer) = i.neighbors[index]

Base.length(i::Neighbors) = length(i.neighbors)

immutable NoNeighbors <: AbstractNeighbors end

function Base.getindex(i::NoNeighbors, index::Integer)
  IndexedTriangleNeighbors(-1, -1, -1)
end

#-------------------------------------------------------------------------------

type Triangles <: AbstractIterable{IndexedTriangle}
  triangles::Vector{IndexedTriangle}
  a::AbstractAttributes
  n::AbstractNeighbors
end

function Base.getindex(i::Triangles, index::Integer)
  if index > length(i.triangles) && index < 1
    throw(TriangleNotFoundException(index))
  else
  t.triangles[index]
  end
end

Base.length(i::Triangles) = length(i.triangles)

getattributes(i::Triangles, index::Integer) = i.a[index]

getneighbors(i::Triangles, index::Integer) = i.n[index]

#-------------------------------------------------------------------------------

abstract AbstractEdges <: AbstractIterable{IndexedEdge}

getmarker(i::AbstractEdges, index::Integer) = Cint(0)

type Edges <: AbstractEdges
  edges::Vector{IndexedEdge}
  m::AbstractMarkers
end

Base.getindex(i::Edges, index::Integer) = i.edges[index]

Base.length(i::Edges) = length(i.edges)

getmarker(i::Edges, index::Integer) = i.m[index]

immutable NoEdges <: AbstractEdges end

Base.getindex(i::NoEdges, index::Integer) = IndexedEdge(0, 0)

#-------------------------------------------------------------------------------

abstract AbstractSegments <: AbstractIterable{IndexedSegment}

getmarker(i::AbstractSegments, index::Integer) = Cint(0)

type Segments <: AbstractSegments
  segments::Vector{IndexedSegment}
  m::AbstractMarkers
end

Base.getindex(i::Segments, index::Integer) = i.segments[index]

Base.length(i::Segments) = length(i.segments)

getmarker(i::Segments, index::Integer) = i.m[index]

immutable NoSegments <: AbstractSegments end

Base.getindex(i::NoSegments, index::Integer) = IndexedSegment(0, 0)

#-------------------------------------------------------------------------------

type SegmentsIterator <: AbstractIterable{Segment}
  n::Nodes
  s::AbstractSegments
end

function getindex(i::SegmentsIterator, index::Integer)
  s::IndexedSegment = i.s[index]
  Segment(i.n[s.a], i.n[s.b], getmarker(i.s, index))  
end

#-------------------------------------------------------------------------------

type EdgesIterator <: AbstractIterable{Segment}
  n::Nodes
  e::AbstractEdges
end

function getindex(i::EdgesIterator, index::Integer)
  s::IndexedEdge = i.e[index]
  Edge(i.n[e.a], i.n[e.b], getmarker(i.e, index))  
end

#-------------------------------------------------------------------------------
# Represents a Triangle with attributes and neighbors.
type Triangle
  index::Cint
  a::Node
  b::Node
  c::Node
  ai::AbstractAttributeIterator
  neighbors::Vector{Cint}
end

getattributes(t::Triangle) = t.ai

getneighbors(t::Triangle) = t.neighbors

type TrianglesIterator <: AbstractIterable{Triangle}
  n::Nodes
  t::Triangles
end

function getindex(i::TrianglesIterator, index::Integer)
  t::IndexedTriangle = i.t[index]
  ai::AbstractAttributeIterator = getattrs(i.t, index)
  n::IndexedTriangleNeighbors = getneighbors(i.t, index) 
  Triangle(i.n[t.a], i.n[t.b], i.n[t.c], ai, getneighbors(n, index))  
end

#-------------------------------------------------------------------------------

type Triangulation
  n::Nodes
  t::Triangles
  s::AbstractSegments
  e::AbstractEdges
end

getnodes(t::Triangulation) = t.n

getsegments(t::Triangulation) = SegmentsIterator(t.nodes, t.s)

getedges(t::Triangulation) = EdgesIterator(t.nodes, t.e)

gettriangles(t::Triangulation) = TriangleIterator(t.nodes, t.triangles)

function gettriangle(t::Triangulation, index::Cint)
  t::IndexedTriangle = t.t[index]
  ai::AbstractAttributeIterator = getattrs(t.t, index)
  n::IndexedTriangleNeighbors = getneighbors(t.t, index) 
  Triangle(i.n[t.a], i.n[t.b], i.n[t.c], ai, getneighbors(n, index))
end

export getnodes

export getsegments

export getedges

export gettriangles

export getattributes

export getmarker

export getfirstnode

export getsecondnode