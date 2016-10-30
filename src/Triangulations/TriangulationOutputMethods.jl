function createOutputEdgesTask(
  triangulation::TriangulationInterface, directory::String,
  outputNodes::Function, fileNames::OutputFileNames, options::DisplayOptions
)
  createOutputEdgesTask(
    triangulation.edgeSection, triangulation, directory, outputNodes, fileNames,
    options
  )
end

function createOutputElementsTask(
  triangulation::TriangulationInterface, directory::String,
  outputNodes::Function, outputEdges::Function, fileNames::OutputFileNames,
  options::DisplayOptions
)
  createOutputElementsTask(
    triangulation.elementSection, triangulation, directory, outputNodes,
    outputEdges, fileNames, options
  )
end

function createOutputSegmentsTask(
  triangulation::TriangulationInterface, directory::String,
  outputNodes::Function, outputEdges::Function, outputElems::Function,
  fileNames::OutputFileNames, options::DisplayOptions
)
  createOutputSegmentsTask(
    triangulation.segmentSection, triangulation, directory, outputNodes,
    outputEdges, outputElems, fileNames, options
  )
end
