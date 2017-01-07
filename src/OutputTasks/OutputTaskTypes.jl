immutable OutputWriter
  f::Function
  fileName::String
end

abstract OutputTaskInterface

immutable OutputNodesTask <: OutputTaskInterface
  triangulation::TriangulationInterface
  directory::DirectoryInterface
  displayAxis::Bool
  displaySegments::Bool
end

immutable OutputEdgesTask <: OutputTaskInterface
  triangulation::TriangulationInterface
  directory::DirectoryInterface
  outputNodes::Function
  displayAxis::Bool
  displaySegments::Bool
end

type OutputNoEdgesTask <: OutputTaskInterface
  triangulation::TriangulationInterface
  directory::DirectoryInterface
  outputNodes::Function
  displayAxis::Bool
  displaySegments::Bool
end

type OutputNoElementsTask <: OutputTaskInterface
  triangulation::TriangulationInterface
  directory::DirectoryInterface
  outputNodes::Function
  outputEdges::Function
  displayAxis::Bool
  displaySegments::Bool
end

type OutputElementsTask <: OutputTaskInterface
  triangulation::TriangulationInterface
  directory::DirectoryInterface
  outputNodes::Function
  outputEdges::Function
  displayAxis::Bool
  displaySegments::Bool
end

type OutputSegmentsTask <: OutputTaskInterface
  triangulation::TriangulationInterface
  directory::DirectoryInterface
  outputNodes::Function
  outputEdges::Function
  outputElems::Function
  displayAxis::Bool
end

type OutputNoSegmentsTask <: OutputTaskInterface
  triangulation::TriangulationInterface
  directory::DirectoryInterface
  outputNodes::Function
  outputEdges::Function
  outputElems::Function
  displayAxis::Bool
end

type OutputTriangulationTask <: OutputTaskInterface
  triangulation::TriangulationInterface
  directory::DirectoryInterface
  outputNodes::Function
  outputEdges::Function
  outputElems::Function
  outputSegments::Function
  displayAxis::Bool
end
