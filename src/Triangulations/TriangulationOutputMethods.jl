function createOutputEdgesTask(
  triangulation::TriangulationInterface,
  directory::DirectoryInterface,
  outputNodes::Function,
  displayAxis::Bool,
  displaySegments::Bool
)
  createOutputEdgesTask(
    triangulation.edgeSection, triangulation, directory, outputNodes,
    displayAxis, displaySegments
  )
end

function createOutputElementsTask(
  triangulation::TriangulationInterface,
  directory::DirectoryInterface,
  outputNodes::Function,
  outputEdges::Function,
  displayAxis::Bool,
  displaySegments::Bool
)
  createOutputElementsTask(
    triangulation.elementSection, triangulation, directory, outputNodes,
    outputEdges, displayAxis, displaySegments
  )
end

function createOutputSegmentsTask(
  triangulation::TriangulationInterface,
  directory::DirectoryInterface,
  outputNodes::Function,
  outputEdges::Function,
  outputElems::Function,
  displayAxis::Bool,
  displaySegments::Bool
)
  createOutputSegmentsTask(
    triangulation.segmentSection, triangulation, directory, outputNodes,
    outputEdges, outputElems, displayAxis, displaySegments
  )
end
