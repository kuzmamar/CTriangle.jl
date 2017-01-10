"""
Represents a point in two dimensional space. Each point has index and a x-coordinate and y-coordinate.
It is used to represent a hole and a vertex in a triangulation.
"""
immutable Point
  index::Int
  xCoordinate::Cdouble
  yCoordinate::Cdouble
end

"""
Represents a vertex with it's point, list of attributes and a boundary marker.
Boundary marker is 0 when there is none.
"""
immutable Node
  point::Point
  attrs::Tuple{Vararg{Cdouble}}
  marker::Cint
end

"""
Represents a triangle. Each triangle has an index, list of points, attributes and a boundary marker.
"""
immutable Element
  index::Int
  points::Tuple{Vararg{Point}}
  attrs::Tuple{Vararg{Cdouble}}
  neighbors::Tuple{Vararg{Int}}
end

"""
Represents a segment with it's two end points and boundary marker.
Boundary marker is 0 when there is none.
"""
immutable Segment
  index::Int
  firstPoint::Point
  secondPoint::Point
  marker::Cint
end

"""
Represents an edge. Each edge has an index, two end points and a boundary marker.
Boundary marker is 0 when there is none.
"""
immutable Edge
  index::Int
  firstPoint::Point
  secondPoint::Point
  marker::Cint
end

"""
Represents a region where we can assign to each triangle an attribute or maximal area size.
Each region is identified by a point.
"""
immutable Region
  point::Point
  attr::Cdouble
  area::Cdouble
end
