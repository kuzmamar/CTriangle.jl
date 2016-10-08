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

immutable Element
  index::Int
  points::Tuple{Vararg{Point}}
  attrs::Tuple{Vararg{Cdouble}}
  neighbors::Tuple{Vararg{Int}}
end

immutable Segment
  index::Int
  firstPoint::Point
  secondPoint::Point
  marker::Cint
end

immutable Edge
  index::Int
  firstPoint::Point
  secondPoint::Point
  marker::Cint
end
