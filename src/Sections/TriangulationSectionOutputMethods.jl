function createOutputEdgesTask(
  section::EdgeTriangulationSection, triangulation::TriangulationInterface,
  directory::String, outputNodes::Function, fileNames::OutputFileNames,
  options::DisplayOptions
)
  OutputEdgesTask(
    triangulation, directory, outputNodes, fileNames, options
  )
end

function createOutputEdgesTask(
  section::NoEdgeTriangulationSection, triangulation::TriangulationInterface,
  directory::String, outputNodes::Function, fileNames::OutputFileNames,
  options::DisplayOptions
)
  OutputNoEdgesTask(
    triangulation, directory, outputNodes, fileNames, options
  )
end


function createOutputElementsTask(
  section::ElementTriangulationSection, triangulation::TriangulationInterface,
  directory::String, outputNodes::Function, outputEdges::Function,
  fileNames::OutputFileNames, options::DisplayOptions
)
  OutputElementsTask(
    triangulation, directory, outputNodes, outputEdges, fileNames, options
  )
end

function createOutputElementsTask(
  section::NoElementTriangulationSection, triangulation::TriangulationInterface,
  directory::String, outputNodes::Function, outputEdges::Function,
  fileNames::OutputFileNames, options::DisplayOptions
)
  OutputNoElementsTask(
    triangulation, directory, outputNodes, outputEdges, fileNames, options
  )
end

function createOutputSegmentsTask(
  section::SegmentTriangulationSection, triangulation::TriangulationInterface,
  directory::String, outputNodes::Function, outputEdges::Function,
  outputElems::Function, fileNames::OutputFileNames, options::DisplayOptions
)
OutputSegmentsTask(
  triangulation, directory, outputNodes, outputEdges, outputElems,
  fileNames, options
)
end

function createOutputSegmentsTask(
  section::NoSegmentTriangulationSection, triangulation::TriangulationInterface,
  directory::String, outputNodes::Function, outputEdges::Function,
  outputElems::Function, fileNames::OutputFileNames, options::DisplayOptions
)
  OutputNoSegmentsTask(
    triangulation, directory, outputNodes, outputEdges, outputElems,
    fileNames, options
  )
end
