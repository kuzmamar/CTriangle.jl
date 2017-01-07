function getNode(triangulation::TriangulationInterface, index::Int)
  getNode(triangulation.nodeSection, index)
end

function getNodes(triangulation::TriangulationInterface)
  NodeIterator(triangulation.nodeSection)
end

function getElement(triangulation::TriangulationInterface, index::Int)
  getElement(triangulation.nodeSection, triangulation.elementSection, index)
end

function getElements(triangulation::TriangulationInterface)
  ElementIterator(
    triangulation.nodeSection,
    triangulation.elementSection
  )
end

function getNeighbors(
  triangulation::TriangulationInterface,
  element::Element
)
  neighbors::Vector{Element} = Vector{Element}(length(element.neighbors))
  current::Int = 1
  for index::Int in element.neighbors
    neighbors[current] = getElement(triangulation, index)
    current = current + 1
  end
  tuple(neighbors...)
end

function getSegments(triangulation::TriangulationInterface)
  SegmentIterator(triangulation.nodeSection, triangulation.segmentSection)
end

function getHoles(triangulation::ConstrainedTriangulationInterface)
  HoleIterator(triangulation.holeSection)
end

function getEdges(triangulation::TriangulationInterface)
  EdgeIterator(triangulation.nodeSection, triangulation.edgeSection)
end

function getRegions(triangulation::ConstrainedDelaunayTriangulation)
  RegionIterator(triangulation.regionSection)
end
