function output(writer::OutputWriter, stream::IO)
  writer.f(stream, writer.fileName)
end

function output(task::OutputNodesTask)
  fileStream::IO = open(
    task.directory,
    getNodesDataFilePath(task.directory)
  )
  for node::Node in getNodes(task.triangulation)
    output(node, fileStream)
  end
  close(fileStream)
  createOutputEdgesTask(
    task.triangulation, task.directory, outputNodes, task.displayAxis, task.displaySegments
  )
end

function output(task::OutputEdgesTask)
  fileStream::IO = open(
    task.directory,
    getEdgesDataFilePath(task.directory)
  )
  for edge::Edge in getEdges(task.triangulation)
    output(edge, fileStream)
  end
  close(fileStream)
  OutputNoElementsTask(
    task.triangulation, task.directory, task.outputNodes, outputEdges,
    task.displayAxis, task.displaySegments
  )
end

function output(task::OutputNoEdgesTask)
  createOutputElementsTask(
    task.triangulation, task.directory, task.outputNodes, ignoreOutput,
    task.displayAxis, task.displaySegments
  )
end

function output(task::OutputElementsTask)
  fileStream::IO = open(
    task.directory,
    getElemsDataFilePath(task.directory)
  )
  for elem::Element in getElements(task.triangulation)
    output(elem, fileStream)
  end
  close(fileStream)
  createOutputSegmentsTask(
    task.triangulation, task.directory,
    task.outputNodes, task.outputEdges, outputElems,
    task.displayAxis, task.displaySegments
  )
end

function output(task::OutputNoElementsTask)
  createOutputSegmentsTask(
    task.triangulation, task.directory,
    task.outputNodes, task.outputEdges, ignoreOutput,
    task.displayAxis, task.displaySegments
  )
end

function output(task::OutputSegmentsTask)
  fileStream::IO = open(
    task.directory,
    getSegmentsDataFilePath(task.directory)
  )
  for segment::Segment in getSegments(task.triangulation)
    output(segment, fileStream)
  end
  close(fileStream)
  OutputTriangulationTask(
    task.triangulation, task.directory,
    task.outputNodes, task.outputEdges, task.outputElems, outputSegments,
    task.displayAxis
  )
end

function output(task::OutputNoSegmentsTask)
  OutputTriangulationTask(
    task.triangulation, task.directory,
    task.outputNodes, task.outputEdges, task.outputElems, ignoreOutput,
    task.displayAxis
  )
end

function createOutputWrites(task::OutputTriangulationTask)
  (
    OutputWriter(
      task.outputNodes,
      getNodesDataFileName(task.directory)
    ),
    OutputWriter(
      task.outputEdges,
      getEdgesDataFileName(task.directory)
    ),
    OutputWriter(
      task.outputElems,
      getElemsDataFileName(task.directory)
    ),
    OutputWriter(
      task.outputSegments,
      getSegmentsDataFileName(task.directory)
    )
  )
end

function output(task::OutputTriangulationTask)
  fileStream::IO = open(
    task.directory,
    getTriangulationFilePath(task.directory)
  )
  outputed::Bool = outputTriangulation(
    fileStream,
    task.displayAxis,
    createOutputWrites(task)
  )
  close(fileStream)
  true
end
