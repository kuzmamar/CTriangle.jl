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
  Element[]
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

Base.length(section::ElementTriangulationSectionInterface) = 0

getAttrs(section::ElementTriangulationSectionInterface) = Cdouble[]

getAttrs(section::ElementTriangulationSection) = section.attrs

function Base.length(section::ElementTriangulationSection)
  length(section.elems) / section.cornerCnt
end
