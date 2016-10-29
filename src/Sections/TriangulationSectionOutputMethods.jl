function createOutputTask(
  section::EdgeTriangulationSection, triangulation::TriangulationInterface,
  directory::String, outputNodes::Function
)
  OutputEdgesTask(triangulation, directory, outputNodes, outputEdges)
end

function createOutputTask(
  section::NoEdgeTriangulationSection, triangulation::TriangulationInterface,
  directory::String, outputNodes::Function
)
  OutputNoEdgesTask(triangulation, directory, outputNodes)
end

function createOutputTask(
  section::ElementTriangulationSection, triangulation::TriangulationInterface,
  directory::String, outputNodes::Function,
)
  OutputNoEdgesTask(triangulation, directory, outputNodes)
end
