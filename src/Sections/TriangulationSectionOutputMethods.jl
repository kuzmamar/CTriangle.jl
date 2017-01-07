function createOutputEdgesTask(
  section::EdgeTriangulationSection,
  triangulation::TriangulationInterface,
  directory::DirectoryInterface,
  outputNodes::Function,
  displayAxis::Bool,
  displaySegments::Bool
)
  OutputEdgesTask(
    triangulation, directory, outputNodes, displayAxis, displaySegments
  )
end

function createOutputEdgesTask(
  section::NoEdgeTriangulationSection,
  triangulation::TriangulationInterface,
  directory::DirectoryInterface,
  outputNodes::Function,
  displayAxis::Bool,
  displaySegments::Bool
)
  OutputNoEdgesTask(
    triangulation, directory, outputNodes, displayAxis, displaySegments
  )
end

function createOutputElementsTask(
  section::ElementTriangulationSection,
  triangulation::TriangulationInterface,
  directory::DirectoryInterface,
  outputNodes::Function,
  outputEdges::Function,
  displayAxis::Bool,
  displaySegments::Bool
)
  OutputElementsTask(
    triangulation, directory, outputNodes, outputEdges, displayAxis, displaySegments
  )
end

function createOutputElementsTask(
  section::NoElementTriangulationSection,
  triangulation::TriangulationInterface,
  directory::DirectoryInterface,
  outputNodes::Function,
  outputEdges::Function,
  displayAxis::Bool,
  displaySegments::Bool
)
  OutputNoElementsTask(
    triangulation, directory, outputNodes, outputEdges, displayAxis, displaySegments
  )
end

function createOutputSegmentsTask(
  section::SegmentTriangulationSection,
  triangulation::TriangulationInterface,
  directory::DirectoryInterface,
  outputNodes::Function,
  outputEdges::Function,
  outputElems::Function,
  displayAxis::Bool,
  displaySegments::Bool
)
  if displaySegments == true
    OutputSegmentsTask(
      triangulation, directory, outputNodes, outputEdges, outputElems,
      displayAxis
    )
  else
    OutputNoSegmentsTask(
      triangulation, directory, outputNodes, outputEdges, outputElems,
      displayAxis
    )
  end
end

function createOutputSegmentsTask(
  section::NoSegmentTriangulationSection,
  triangulation::TriangulationInterface,
  directory::DirectoryInterface,
  outputNodes::Function,
  outputEdges::Function,
  outputElems::Function,
  displayAxis::Bool,
  displaySegments::Bool
)
  OutputNoSegmentsTask(
    triangulation, directory, outputNodes, outputEdges, outputElems,
    displayAxis
  )
end
