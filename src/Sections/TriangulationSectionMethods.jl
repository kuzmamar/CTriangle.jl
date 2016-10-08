function getNode(section::NodeTriangulationSection, index::Int)
  createNode(
    section.points, section.attrs, section.attrCnt, section.markers, index
  )
end

function getNodes(section::NodeTriangulationSection)
  NodeIterator(section.points, section.attrs, section.attrCnt, section.markers)
end

function getElements(
  nodeSection::NodeTriangulationSection,
  elementSection::NoElementTriangulationSection,
  neighborSection::NeighborTriangulationSectionInterface
)
  ()
end

function getElements(
  nodeSection::NodeTriangulationSection,
  elementSection::ElementTriangulationSection,
  neighborSection::NeighborTriangulationSectionInterface
)
  ElementIterator(nodeSection, elementSection, neighborSection)
end

function getElement(
  nodeSection::NodeTriangulationSection,
  elementSection::NoElementTriangulationSection,
  neighborSection::NeighborTriangulationSectionInterface,
  index::Int
)
  error("No element found on index \"$index\".")
end

function getElement(
  nodeSection::NodeTriangulationSection,
  elementSection::ElementTriangulationSection,
  neighborSection::NeighborTriangulationSectionInterface,
  index::Int
)
  createElement(nodeSection, elementSection, neighborSection, index)
end

function createElement(
  nodeSection::NodeTriangulationSection,
  elementSection::ElementTriangulationSection,
  neighborSection::NeighborTriangulationSectionInterface,
  index::Int
)
  if index > 0 && index <= length(elementSection)
    Element(
      index,
      createPoints(nodeSection, elementSection, index),
      createAttrs(elementSection, index),
      createNeighbors(nodeSection, elementSection, neighborSection, index)
    )
  else
    error("No element found on index \"$index\".")
  end
end

function createPoints(
  nodeSection::NodeTriangulationSection,
  elementSection::ElementTriangulationSection,
  index::Int
)
  last::Int = index * elementSection.cornerCnt
  first::Int = last - elementSection.cornerCnt + 1
  points::Vector{Point} = Vector{Point}(elementSection.cornerCnt)
  current::Int = 1
  for i::Int in first:last
    points[current] = createPoint(nodeSection.points, Int(elementSection.elems[i]))
    current = current + 1
  end
  tuple(points...)
end

function createAttrs(section::ElementTriangulationSection, index::Int)
  createAttrs(section.attrs, section.attrCnt, index)
end

function createNeighbors(
  nodeSection::NodeTriangulationSection,
  elementSection::ElementTriangulationSection,
  neighborSection::NeighborTriangulationSection,
  index::Int
)
  tuple(filterNeighbors(neighborSection.neighbors, index)...)
end

function createNeighbors(
  nodeSection::NodeTriangulationSection,
  elementSection::ElementTriangulationSection,
  neighborSection::NoNeighborTriangulationSection,
  index::Int
)
  ()
end

function Base.length(section::ElementTriangulationSection)
  length(section.elems) / section.cornerCnt
end

function Base.length(section::SegmentTriangulationSection)
  length(section.segments) / 2
end

function Base.length(section::EdgeTriangulationSection)
  length(section.edges) / 2
end

function getSegments(
  nodeSection::NodeTriangulationSection,
  segmentSection::NoSegmentTriangulationSection
)
  ()
end

function getSegments(
  nodeSection::NodeTriangulationSection,
  segmentSection::SegmentTriangulationSection
)
  SegmentIterator(nodeSection, segmentSection)
end

function createSegment(
  nodeSection::NodeTriangulationSection,
  segmentSection::SegmentTriangulationSection,
  index::Int
)
  if index > 0 && index <= length(segmentSection)
    second::Int = index * 2
    Segment(
      index,
      createPoint(nodeSection.points, Int(segmentSection.segments[second - 1])),
      createPoint(nodeSection.points, Int(segmentSection.segments[second])),
      getMarker(segmentSection.markers, index)
    )
  else
    error("No segment found on index \"$index\".")
  end
end

getHoles(::HoleTriangulationSectionInterface) = ()

getHoles(section::HoleTriangulationSection) = PointIterator(section.holes)

function getEdges(
  nodeSection::NodeTriangulationSection,
  edgeSection::NoEdgeTriangulationSection
)
  ()
end

function getEdges(
  nodeSection::NodeTriangulationSection,
  edgeSection::EdgeTriangulationSection
)
  EdgeIterator(nodeSection, edgeSection)
end

function createEdge(
  nodeSection::NodeTriangulationSection,
  edgeSection::EdgeTriangulationSection,
  index::Int
)
  if index > 0 && index <= length(edgeSection)
    second::Int = index * 2
    Edge(
      index,
      createPoint(nodeSection.points, Int(edgeSection.edges[second - 1])),
      createPoint(nodeSection.points, Int(edgeSection.edges[second])),
      getMarker(edgeSection.markers, index)
    )
  else
    error("No edge found on index \"$index\".")
  end
end
