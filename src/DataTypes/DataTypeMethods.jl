function output(point::Point, stream::IO)
  write(stream, "$(point.xCoordinate) $(point.yCoordinate)\n")
end

function output(node::Node, stream::IO)
  output(node.point, stream)
end

function output(edge::Edge, stream::IO)
  output(edge.firstPoint, stream)
  output(edge.secondPoint, stream)
  write(stream, "\n")
end

function output(elem::Element, stream::IO)
  output(elem.points[1], stream)
  output(elem.points[2], stream)
  output(elem.points[3], stream)
  output(elem.points[1], stream)
  write(stream, "\n")
end

function output(segment::Segment, stream::IO)
  output(segment.firstPoint, stream)
  output(segment.secondPoint, stream)
  write(stream, "\n")
end
