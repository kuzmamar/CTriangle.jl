const DATA_EXT = "dat"

const TRIANGULATION_EXT = "tex"

const NODES_OUTPUT_DATA_FILE_NAME = "nodes"

const EDGES_OUTPUT_DATA_FILE_NAME = "edges"

const ELEMS_OUTPUT_DATA_FILE_NAME = "elements"

const SEGMENTS_OUTPUT_DATA_FILE_NAME = "segments"

const TRIANGULATION_OUTPUT_FILE_NAME = "triangulation"

const NODES_DEFAULT_DISPLAY_OPTIONS = "only marks, black, mark size=1pt";

const EDGES_DEFAULT_DISPLAY_OPTIONS = "no markers, black, line join=round, line cap=round";

const ELEMS_DEFAULT_DISPLAY_OPTIONS = "no markers, black, line join=round, line cap=round";

const SEGMENTS_DEFAULT_DISPLAY_OPTIONS = "no markers, red, line join=round, line cap=round";

abstract DirectoryInterface

immutable Directory <: DirectoryInterface
  directory::String
  nodesDataFileName::String
  edgesDataFileName::String
  elemsDataFileName::String
  segmentsDataFileName::String
  triangulationFileName::String
  function Directory(
    directory::String,
    nodesDataFileName::String = NODES_OUTPUT_DATA_FILE_NAME,
    edgesDataFileName::String = EDGES_OUTPUT_DATA_FILE_NAME,
    elemsDataFileName::String = ELEMS_OUTPUT_DATA_FILE_NAME,
    segmentsDataFileName::String = SEGMENTS_OUTPUT_DATA_FILE_NAME,
    triangulationFileName::String = TRIANGULATION_OUTPUT_FILE_NAME
  )
    new(
      directory, nodesDataFileName, edgesDataFileName, elemsDataFileName,
      segmentsDataFileName, triangulationFileName
    )
  end
end

type FakeDirectory <: DirectoryInterface
  outputed::Bool
  directory::String
  nodesDataFileName::String
  edgesDataFileName::String
  elemsDataFileName::String
  segmentsDataFileName::String
  triangulationFileName::String
  function FakeDirectory()
    new(
      false, "fake_dir",
      NODES_OUTPUT_DATA_FILE_NAME,
      EDGES_OUTPUT_DATA_FILE_NAME,
      ELEMS_OUTPUT_DATA_FILE_NAME,
      SEGMENTS_OUTPUT_DATA_FILE_NAME,
      TRIANGULATION_OUTPUT_FILE_NAME
    )
  end
end
