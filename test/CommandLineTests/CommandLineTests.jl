@testset "Command Line Unit Tests" begin
  # Test that unsupported options are removed.
  inputs = [
    ["a1.2zrvS20", "a1.2rS20"],
  ]

  executeTests(inputs, function(input)
      @test input[2] == CTriangle.parseOptions(CTriangle.CommandLine(), input[1])
    end
  )

  # Test that specified commands are created.
  inputs = [
    ["", CTriangle.DelaunayFileCommand],
    ["aa1.2q0.5", CTriangle.DelaunayFileCommand],
    ["aa1.2q0.5r", CTriangle.DelaunayRefinementFileCommand],
    ["aa1.2q0.5p", CTriangle.ConstrainedDelaunayFileCommand],
    ["aa1.2q0.5pr", CTriangle.ConstrainedDelaunayRefinementFileCommand]
  ]

  executeTests(inputs, function(input)
      commandLine = CTriangle.CommandLine()
      @test isa(CTriangle.createCommand(
        commandLine, CTriangle.parseOptions(commandLine, input[1]), ""), input[2]
      )
    end
  )

  # Test that command line is configured properly.
  inputs = [
    [
      "",
      function(commandLine::CTriangle.CommandLine)
        @test true == commandLine.delaunay
        @test false == commandLine.constrainedDelaunay
        @test false == commandLine.refinement
      end
    ],
    [
      "a1.2zrvS20",
      function(commandLine::CTriangle.CommandLine)
        @test true == commandLine.delaunay
        @test true == commandLine.refinement
      end
    ],
    [
      "aa1.2q0.5pr",
      function(commandLine::CTriangle.CommandLine)
        @test false == commandLine.delaunay
        @test true == commandLine.constrainedDelaunay
        @test true == commandLine.refinement
        @test true == commandLine.useRegions
        @test true == commandLine.useAreas
      end
    ],
    [
      "pO",
      function(commandLine::CTriangle.CommandLine)
        @test false == commandLine.delaunay
        @test true == commandLine.constrainedDelaunay
        @test false == commandLine.refinement
        @test false == commandLine.useRegions
        @test false == commandLine.useHoles
      end
    ],
  ]

  executeTests(inputs, function(input)
      commandLine = CTriangle.CommandLine()
      CTriangle.parseOptions(commandLine, input[1])
      input[2](commandLine)
    end
  )
end
