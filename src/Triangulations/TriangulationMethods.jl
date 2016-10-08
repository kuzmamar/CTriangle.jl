function getNode(triangulation::TriangulationInterface, index::Int)
  getNode(triangulation.nodeSection, index)
end

function getNodes(triangulation::TriangulationInterface)
  getNodes(triangulation.nodeSection)
end

function getElement(triangulation::TriangulationInterface, index::Int)
  getElement(triangulation.nodeSection, triangulation.elementSection, triangulation.neighborSection, index)
end

function getElements(triangulation::TriangulationInterface)
  getElements(
    triangulation.nodeSection,
    triangulation.elementSection,
    triangulation.neighborSection
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
  getSegments(triangulation.nodeSection, triangulation.segmentSection)
end

function getHoles(triangulation::ConstrainedTriangulationInterface)
  getHoles(triangulation.holeSection)
end

function getEdges(triangulation::TriangulationInterface)
  getEdges(triangulation.nodeSection, triangulation.edgeSection)
end
