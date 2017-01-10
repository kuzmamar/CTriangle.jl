"""
    getNode(triangulation::TriangulationInterface, index::Int)

Returns a vertex with a given index.
"""
function getNode(triangulation::TriangulationInterface, index::Int)
  getNode(triangulation.nodeSection, index)
end

"""
    getNodes(triangulation::TriangulationInterface)

Returns an iterator to a list of vertices.
"""
function getNodes(triangulation::TriangulationInterface)
  NodeIterator(triangulation.nodeSection)
end

"""
    getElement(triangulation::TriangulationInterface, index::Int)

Returns a triangle with a given index.
"""
function getElement(triangulation::TriangulationInterface, index::Int)
  getElement(triangulation.nodeSection, triangulation.elementSection, index)
end

"""
    getElements(triangulation::TriangulationInterface)

Returns an iterator to a list of triangles.
"""
function getElements(triangulation::TriangulationInterface)
  ElementIterator(
    triangulation.nodeSection,
    triangulation.elementSection
  )
end

"""
    getNeighbors(triangulation::TriangulationInterface, element::Element)

Returns list of triangles that are neighbors to the given triangle.
"""
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

"""
    getSegments(triangulation::TriangulationInterface)

Returns an iterator to a list of segments.
"""
function getSegments(triangulation::TriangulationInterface)
  SegmentIterator(triangulation.nodeSection, triangulation.segmentSection)
end

"""
    getHoles(triangulation::ConstrainedTriangulationInterface)

Returns an iterator to a list of holes.
"""
function getHoles(triangulation::ConstrainedTriangulationInterface)
  HoleIterator(triangulation.holeSection)
end

"""
    getEdges(triangulation::TriangulationInterface)

Returns an iterator to a list of edges.
"""
function getEdges(triangulation::TriangulationInterface)
  EdgeIterator(triangulation.nodeSection, triangulation.edgeSection)
end

"""
    getRegions(triangulation::ConstrainedDelaunayTriangulation)

Returns an iterator to a list of regions.
"""
function getRegions(triangulation::ConstrainedDelaunayTriangulation)
  RegionIterator(triangulation.regionSection)
end
