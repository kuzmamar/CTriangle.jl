

# Represents a Node with a possible boundary marker and attributes.
type Node
  a::Point
  marker::Cint
  i::AbstractAttributeIterator
end

attributes(n::Node) = n.i

# Represents a Segment with two ending points and possible boundary marker.
type Segment
  a::Node
  b::Node
  marker::Cint
end

# Represents a Triangle with attributes.
type Triangle
  a::Node
  b::Node
  c::Node
  i::AbstractAttributeIterator
end

attributes(t::Triangle) = t.i

# Represents an Edge.
type Edge
  a::Node
  b::Node
  m::Cint
end

# Represents an Edge.
type Hole
  a::Point
end
