function outputGraph(
  triangulation::TriangulationInterface, directory::String,
  fileNames::OutputFileNames, displayOptions::DisplayOptions
)
  output( # output of triangulation
    output( # output of segments
      output( # output of elements
        output( # output of edges
          output( # output of nodes
            OutputNodesTask(
              triangulation, directory, fileNames, displayOptions
            )
          )
        )
      )
    )
  )
end
