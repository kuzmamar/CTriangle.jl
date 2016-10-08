immutable Point
  index::Int
  xCoordinate::Cdouble
  yCoordinate::Cdouble
end

immutable Node
  point::Point
  attrs::Tuple{Vararg{Cdouble}}
  marker::Cint
end

Node(point::Point) = Node(point, (), Cint(0))

immutable Element
  index::Int
  points::Tuple{Vararg{Point}}
  attrs::Tuple{Vararg{Cdouble}}
  neighbors::Tuple{Vararg{Element}}
end

function Element(index::Int, points::Tuple{Vararg{Point}})
  Element(index, points, (), ())
end

immutable Segment
  index::Int
  firstPoint::Point
  secondPoint::Point
  marker::Cint
end

function Segment(index::Int, firstPoint::Point, secondPoint::Point)
  Segment(index, firstPoint, secondPoint, Cint(0))
end

immutable Edge
  index::Int
  firstPoint::Point
  secondPoint::Point
  marker::Cint
end

function Edge(index::Int, firstPoint::Point, secondPoint::Point)
  Edge(index, firstPoint, secondPoint, Cint(0))
end
