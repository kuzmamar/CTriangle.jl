const DATA_EXT = "dat"

const TRIANGULATION_EXT = "tex"

const NODES_OUTPUT_DATA_FILE_NAME = "nodes"

const EDGES_OUTPUT_DATA_FILE_NAME = "edges"

const ELEMS_OUTPUT_DATA_FILE_NAME = "elements"

const SEGMENTS_OUTPUT_DATA_FILE_NAME = "segments"

const TRIANGULATION_OUTPUT_FILE_NAME = "triangulation"

const NODES_DEFAULT_DISPLAY_OPTIONS = ("only marks", "black");

const EDGES_DEFAULT_DISPLAY_OPTIONS = (
  "no markers", "black", "line join=round", "line cap=round"
);

const ELEMS_DEFAULT_DISPLAY_OPTIONS = (
  "no markers", "black", "line join=round", "line cap=round"
);

const SEGMENTS_DEFAULT_DISPLAY_OPTIONS = (
  "no markers", "red", "line join=round", "line cap=round"
);

immutable DisplayOptions
  displayAxis::Bool
  nodesDisplayOptions::Tuple{Vararg{String}}
  edgesDisplayOptions::Tuple{Vararg{String}}
  elemsDisplayOptions::Tuple{Vararg{String}}
  segmentsDisplayOptions::Tuple{Vararg{String}}
end

immutable OutputFileNames
  nodesDataFileName::String
  edgesDataFileName::String
  elemsDataFileName::String
  segmentsDataFileName::String
  triangulationFileName::String
  function OutputFileNames(
    nodesDataFileName::String = NODES_OUTPUT_DATA_FILE_NAME,
    edgesDataFileName::String = EDGES_OUTPUT_DATA_FILE_NAME,
    elemsDataFileName::String = ELEMS_OUTPUT_DATA_FILE_NAME,
    segmentsDataFileName::String = SEGMENTS_OUTPUT_DATA_FILE_NAME,
    triangulationFileName::String = TRIANGULATION_OUTPUT_FILE_NAME
  )
    new(
      nodesDataFileName, edgesDataFileName, elemsDataFileName,
      segmentsDataFileName, triangulationFileName
    )
  end
end

immutable OutputWriter
  f::Function
  fileName::String
  displayOptions::Tuple{Vararg{String}}
end

abstract OutputTaskInterface

type OutputNodesTask <: OutputTaskInterface
  triangulation::TriangulationInterface
  directory::String
  fileNames::OutputFileNames
  options::DisplayOptions
end

type OutputEdgesTask <: OutputTaskInterface
  triangulation::TriangulationInterface
  directory::String
  outputNodes::Function
  fileNames::OutputFileNames
  options::DisplayOptions
end

type OutputNoEdgesTask <: OutputTaskInterface
  triangulation::TriangulationInterface
  directory::String
  outputNodes::Function
  fileNames::OutputFileNames
  options::DisplayOptions
end

type OutputNoElementsTask <: OutputTaskInterface
  triangulation::TriangulationInterface
  directory::String
  outputNodes::Function
  outputEdges::Function
  fileNames::OutputFileNames
  options::DisplayOptions
end

type OutputElementsTask <: OutputTaskInterface
  triangulation::TriangulationInterface
  directory::String
  outputNodes::Function
  outputEdges::Function
  fileNames::OutputFileNames
  options::DisplayOptions
end

type OutputSegmentsTask <: OutputTaskInterface
  triangulation::TriangulationInterface
  directory::String
  outputNodes::Function
  outputEdges::Function
  outputElems::Function
  fileNames::OutputFileNames
  options::DisplayOptions
end

type OutputNoSegmentsTask <: OutputTaskInterface
  triangulation::TriangulationInterface
  directory::String
  outputNodes::Function
  outputEdges::Function
  outputElems::Function
  fileNames::OutputFileNames
  options::DisplayOptions
end

type OutputTriangulationTask <: OutputTaskInterface
  triangulation::TriangulationInterface
  directory::String
  outputNodes::Function
  outputEdges::Function
  outputElems::Function
  outputSegments::Function
  fileNames::OutputFileNames
  options::DisplayOptions
end
