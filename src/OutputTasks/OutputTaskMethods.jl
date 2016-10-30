function DisplayOptions(;
  displayAxis = true,
  nodesDisplayOptions = NODES_DEFAULT_DISPLAY_OPTIONS,
  edgesDisplayOptions = EDGES_DEFAULT_DISPLAY_OPTIONS,
  elemsDisplayOptions = ELEMS_DEFAULT_DISPLAY_OPTIONS,
  segmentsDisplayOptions = SEGMENTS_DEFAULT_DISPLAY_OPTIONS
)
  DisplayOptions(
    displayAxis, nodesDisplayOptions, edgesDisplayOptions,
    elemsDisplayOptions, segmentsDisplayOptions
  )
end

function output(writer::OutputWriter, stream::IO)
  writer.f(stream, writer.fileName, writer.displayOptions)
end

function getNodesDataFilePath(fileNames::OutputFileNames, directory::String)
  getFilePath(directory, fileNames.nodesDataFileName, DATA_EXT)
end

function getEdgesDataFilePath(fileNames::OutputFileNames, directory::String)
  getFilePath(directory, fileNames.edgesDataFileName, DATA_EXT)
end

function getElemsDataFilePath(fileNames::OutputFileNames, directory::String)
  getFilePath(directory, fileNames.elemsDataFileName, DATA_EXT)
end

function getSegmentsDataFilePath(fileNames::OutputFileNames, directory::String)
  getFilePath(directory, fileNames.segmentsDataFileName, DATA_EXT)
end

function getTriangulationFilePath(fileNames::OutputFileNames, directory::String)
  getFilePath(directory, fileNames.triangulationFileName, TRIANGULATION_EXT)
end

function getNodesDataFileName(fileNames::OutputFileNames)
  getFileName(fileNames.nodesDataFileName, DATA_EXT)
end

function getEdgesDataFileName(fileNames::OutputFileNames)
  getFileName(fileNames.edgesDataFileName, DATA_EXT)
end

function getElemsDataFileName(fileNames::OutputFileNames)
  getFileName(fileNames.elemsDataFileName, DATA_EXT)
end

function getSegmentsDataFileName(fileNames::OutputFileNames)
  getFileName(fileNames.segmentsDataFileName, DATA_EXT)
end

function getNodeDisplayOptions(options::DisplayOptions)
  options.nodesDisplayOptions
end

function getEdgesDisplayOptions(options::DisplayOptions)
  options.edgesDisplayOptions
end

function getElemsDisplayOptions(options::DisplayOptions)
  options.elemsDisplayOptions
end

function getSegmentsDisplayOptions(options::DisplayOptions)
  options.segmentsDisplayOptions
end

getDisplayAxisOption(options::DisplayOptions) = options.displayAxis

function output(task::OutputNodesTask)
  fileStream::IO = open(
    getNodesDataFilePath(task.fileNames, task.directory), "w"
  )
  for node::Node in getNodes(task.triangulation)
    output(node, fileStream)
  end
  close(fileStream)
  createOutputEdgesTask(
    task.triangulation, task.directory, outputNodes, task.fileNames, task.options
  )
end

function output(task::OutputEdgesTask)
  fileStream::IO = open(
    getEdgesDataFilePath(task.fileNames, task.directory), "w"
  )
  for edge::Edge in getEdges(task.triangulation)
    output(edge, fileStream)
  end
  close(fileStream)
  OutputNoElementsTask(
    task.triangulation, task.directory, task.outputNodes, outputEdges,
    task.fileNames, task.options
  )
end

function output(task::OutputNoEdgesTask)
  createOutputElementsTask(
    task.triangulation, task.directory, task.outputNodes, ignoreOutput,
    task.fileNames, task.options
  )
end

function output(task::OutputElementsTask)
  fileStream::IO = open(
    getElemsDataFilePath(task.fileNames, task.directory), "w"
  )
  for elem::Element in getElements(task.triangulation)
    output(elem, fileStream)
  end
  close(fileStream)
  createOutputSegmentsTask(
    task.triangulation, task.directory,
    task.outputNodes, task.outputEdges, outputElems,
    task.fileNames, task.options
  )
end

function output(task::OutputNoElementsTask)
  createOutputSegmentsTask(
    task.triangulation, task.directory,
    task.outputNodes, task.outputEdges, ignoreOutput,
    task.fileNames, task.options
  )
end

function output(task::OutputSegmentsTask)
  fileStream::IO = open(
    getSegmentsDataFilePath(task.fileNames, task.directory), "w"
  )
  for segment::Segment in getSegments(task.triangulation)
    output(segment, fileStream)
  end
  close(fileStream)
  OutputTriangulationTask(
    task.triangulation, task.directory,
    task.outputNodes, task.outputEdges, task.outputElems, outputSegments,
    task.fileNames, task.options
  )
end

function output(task::OutputNoSegmentsTask)
  OutputTriangulationTask(
    task.triangulation, task.directory,
    task.outputNodes, task.outputEdges, task.outputElems, ignoreOutput,
    task.fileNames, task.options
  )
end

function createOutputWrites(task::OutputTriangulationTask)
  (
    OutputWriter(
      task.outputNodes,
      getNodesDataFileName(task.fileNames),
      getNodeDisplayOptions(task.options)
    ),
    OutputWriter(
      task.outputEdges,
      getEdgesDataFileName(task.fileNames),
      getEdgesDisplayOptions(task.options)
    ),
    OutputWriter(
      task.outputElems,
      getElemsDataFileName(task.fileNames),
      getElemsDisplayOptions(task.options)
    ),
    OutputWriter(
      task.outputSegments,
      getSegmentsDataFileName(task.fileNames),
      getSegmentsDisplayOptions(task.options)
    )
  )
end

function output(task::OutputTriangulationTask)
  fileStream::IO = open(
    getTriangulationFilePath(task.fileNames, task.directory), "w"
  )
  outputTriangulation(
    fileStream, getDisplayAxisOption(task.options),
    createOutputWrites(task)
  )
  close(fileStream)
end
