function addExtension(fileName::String, extension::String)
  if endswith(fileName, extension) == true
    fileName
  else
    "$(fileName).$(extension)"
  end
end

function getFilePath(directory::String, fileName::String, extension::String)
  addExtension("$(directory)/$(fileName)", extension)
end

function getFileName(fileName::String, extension::String)
  addExtension(fileName, extension)
end

function outputPlotStart(fileStream::IO)
  write(fileStream, "\t\\addplot[")
end

function outputPlotEnd(fileStream::IO)
  write(fileStream, "]")
end

function outputPlotData(fileStream::IO, fileName::String)
  write(fileStream, " table {$(getFileName(fileName, DATA_EXT))};\n")
end

ignoreOutput(fileStream::IO, fileName::String) = return

function outputNodes(fileStream::IO, fileName::String)
  outputPlotStart(fileStream)
  write(fileStream, NODES_DEFAULT_DISPLAY_OPTIONS)
  outputPlotEnd(fileStream)
  outputPlotData(fileStream, fileName)
end

function outputElems(fileStream::IO, fileName::String)
  outputPlotStart(fileStream)
  write(fileStream, ELEMS_DEFAULT_DISPLAY_OPTIONS)
  outputPlotEnd(fileStream)
  outputPlotData(fileStream, fileName)
end

function outputEdges(fileStream::IO, fileName::String)
  outputPlotStart(fileStream)
  write(fileStream, EDGES_DEFAULT_DISPLAY_OPTIONS)
  outputPlotEnd(fileStream)
  outputPlotData(fileStream, fileName)
end

function outputSegments(fileStream::IO, fileName::String)
  outputPlotStart(fileStream)
  write(fileStream, SEGMENTS_DEFAULT_DISPLAY_OPTIONS)
  outputPlotEnd(fileStream)
  outputPlotData(fileStream, fileName)
end

function outputTriangulation(
  fileStream::IO,
  displayAxis::Bool,
  outputWrites::Tuple{OutputWriter, OutputWriter, OutputWriter, OutputWriter}
)
  write(fileStream, "\\documentclass{standalone}\n\\usepackage{pgfplots}\n\\begin{document}\n\\begin{tikzpicture}\n\\begin{axis}")
  if displayAxis == false
    write(fileStream, "[axis lines=none]")
  end
  write(fileStream, "\n")
  for outputWriter::OutputWriter in outputWrites
    output(outputWriter, fileStream)
  end
  write(fileStream, "\\end{axis}\n\\end{tikzpicture}\n\\end{document}\n")
  true
end

function doOutputGraph(
  triangulation::TriangulationInterface,
  directory::DirectoryInterface,
  displayAxis::Bool,
  displaySegments::Bool
)
  output( # output of triangulation
    output( # output of segments
      output( # output of elements
        output( # output of edges
          output( # output of nodes
            OutputNodesTask(
              triangulation, directory, displayAxis, displaySegments
            )
          )
        )
      )
    )
  )
end
