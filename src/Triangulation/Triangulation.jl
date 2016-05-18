# Represents a Node with a possible boundary marker and attributes.
type Node
  p::Point
  i::AbstractAttributeIterator
  marker::Cint
end

getattrs(n::Node) = n.i

getpoint(n::Node) = n.p

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

Base.length(i::Markers) = length(i.markers)

immutable NoMarkers <: AbstractMarkers end

#-------------------------------------------------------------------------------

type Nodes <: AbstractIterable{Node}
  points::Vector{Point}
  a::AbstractAttributes
  m::AbstractMarkers
  orders::Dict{Point, Cint}
end

function Nodes(points::Vector{Point}, a::AbstractAttributes,
               m::AbstractMarkers)
  orders::Dict{Point, Cint}
  index::Cint = 1
  for p::Point in points
    orders[p] = index
    index = index + 1
  end
  Nodes(points, a, m, orders)
end

function Base.getindex(i::Nodes, index::Integer)
  Node(i.points[index], i.a[index], i.m[index])
end

function Base.findindex(i::Nodes, n::Node)
  if haskey(i.orders, n.p)
    i.orders[n.p]
  else
    throw(NodeNotFoundException())
  end
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
  orders::Dict{IndexedTriangle, Cint}
end

function Triangles(triangles::Vector{IndexedTriangle}, a::AbstractAttributes,
               n::AbstractNeighbors)
  orders::Dict{Point, Cint}
  index::Cint = 1
  for t::IndexedTriangle in triangles
    orders[t] = index
    index = index + 1
  end
  Nodes(triangles, a, n, orders)
end

function Base.getindex(i::Triangles, index::Integer)
  i.triangles[index]
end

function Base.findindex(i::Triangles, t::IndexedTriangle)
  if haskey(i.orders, t)
    i.orders[t]
  else
    throw(TriangleNotFoundException())
  end
end

Base.length(i::Triangles) = length(i.triangles)

getattrs(i::Triangles, index::Integer) = i.a[index]

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

type SegmentIterator <: AbstractIterable{Segment}
  n::Nodes
  s::AbstractSegments
end


Base.length(i::SegmentIterator) = length(i.s)

function Base.getindex(i::SegmentIterator, index::Integer)
  s::IndexedSegment = i.s[index]
  Segment(i.n[s.a], i.n[s.b], getmarker(i.s, index))  
end

#-------------------------------------------------------------------------------

type EdgeIterator <: AbstractIterable{Edge}
  n::Nodes
  e::AbstractEdges
end

Base.length(i::EdgeIterator) = length(i.e)

function Base.getindex(i::EdgeIterator, index::Integer)
  e::IndexedEdge = i.e[index]
  println(e)
  Edge(i.n[e.a], i.n[e.b], getmarker(i.e, index))  
end

#-------------------------------------------------------------------------------
# Represents a Triangle with attributes and neighbors.
type Triangle
  a::Node
  b::Node
  c::Node
  ai::AbstractAttributeIterator
end

getattrs(t::Triangle) = t.ai

type TriangleIterator <: AbstractIterable{Triangle}
  n::Nodes
  t::Triangles
end

Base.length(i::TriangleIterator) = length(i.t)

function getindex(i::TriangleIterator, index::Integer)
  t::IndexedTriangle = i.t[index]
  ai::AbstractAttributeIterator = getattrs(i.t, index)
  Triangle(i.n[t.a], i.n[t.b], i.n[t.c], ai)  
end

#-------------------------------------------------------------------------------

type Triangulation
  n::Nodes
  t::Triangles
  s::AbstractSegments
  e::AbstractEdges
end

getnodes(t::Triangulation) = t.n

getsegments(t::Triangulation) = SegmentIterator(t.n, t.s)

getedges(t::Triangulation) = EdgeIterator(t.n, t.e)

gettriangles(t::Triangulation) = TriangleIterator(t.n, t.t)

function getneighbors(t::Triangulation, tr::Triangle)
  result::Vector{Triangle} = []
  try
    aindex::Cint = findindex(t.n, tr.a)
    bindex::Cint = findindex(t.n, tr.b)
    cindex::Cint = findindex(t.n, tr.c)  
  catch e::NodeNotFoundException
    throw(TriangleNotFoundException())
  end
  tindex::Cint = findindex(t.t, IndexedTriangle(aindex, bindex, cindex))
  n::IndexedTriangleNeighbors = getneighbors(t.t, tindex)
  neighbors::Vector{Cint} = getneighbors(n)
  for i::Cint in neighbors
    t1::IndexedTriangle = t.t[i]
    push!(Triangle(t.n[t1.a], t.n[t1.b], t.n[t1.c], getattrs(t.t, i)))
  end 
end

export Segment

export Edge

export Node

export Triangle

export getnodes

export getsegments

export getedges

export gettriangles

export getattrs

export getmarker

export getfirstnode

export getsecondnode