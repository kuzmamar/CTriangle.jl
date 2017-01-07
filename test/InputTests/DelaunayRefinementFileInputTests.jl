@testset "Delaunay Refinement File Input Unit Tests" begin
  inputs = [
    [
      CTriangle.FakeNodeName([ # fake node file
        "0 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
        "2 1 0\n",
      ]),
      CTriangle.FakeEleName([ # fake ele file
        "0 3 0\n"
      ]),
      CTriangle.FakeAreaName([ # fake area file
        "0\n"
      ]),
      true,
      function (input)
        cmd = CTriangle.DelaunayRefinementFileCommand(
          "",
          input[1],
          input[2],
          input[3],
          input[4]
        )
        # Test that input is created.
        @test isa(CTriangle.createInput(cmd), CTriangle.DelaunayRefinementFileInput) == true
      end
    ],
    [
      CTriangle.FakeNodeName([ # fake node file
        "3 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
        "2 1 0\n",
      ]),
      CTriangle.FakeEleName([ # fake ele file
        "1 3 0\n",
        "0 0 2 1"
      ]),
      CTriangle.FakeAreaName([ # fake area file
        "0\n"
      ]),
      true,
      function (input)
        cmd = CTriangle.DelaunayRefinementFileCommand(
          "",
          input[1],
          input[2],
          input[3],
          input[4]
        )
        input::CTriangle.DelaunayRefinementFileInput = CTriangle.createInput(cmd)
        # Test that areas are empty even if we want to read them.
        @test isa(input.areaFile.areaSection, CTriangle.NoAreaFileSection) == true
      end
    ],
    [
      CTriangle.FakeNodeName([ # fake node file
        "3 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
        "2 1 0\n",
      ]),
      CTriangle.FakeEleName([ # fake ele file
        "0 3 0\n"
      ]),
      CTriangle.FakeAreaName([ # fake area file
        "1\n",
        "1 0.5\n"
      ]),
      true,
      function (input)
        cmd = CTriangle.DelaunayRefinementFileCommand(
          "",
          input[1],
          input[2],
          input[3],
          input[4]
        )
        input::CTriangle.DelaunayRefinementFileInput = CTriangle.createInput(cmd)
        # Test that areas are read.
        @test isa(input.areaFile.areaSection, CTriangle.AreaFileSection) == true
      end
    ],
    [
      CTriangle.FakeNodeName([ # fake node file
        "3 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
        "2 1 0\n",
      ]),
      CTriangle.FakeEleName([ # fake ele file
        "0 3 0\n"
      ]),
      CTriangle.FakeAreaName([ # fake area file
        "1\n",
        "1 0.5\n"
      ]),
      false,
      function (input)
        cmd = CTriangle.DelaunayRefinementFileCommand(
          "",
          input[1],
          input[2],
          input[3],
          input[4]
        )
        input::CTriangle.DelaunayRefinementFileInput = CTriangle.createInput(cmd)
        # Test that areas are not read.
        @test isa(input.areaFile.areaSection, CTriangle.NoAreaFileSection) == true
      end
    ],
  ]

  executeTests(
      inputs,
      function(input)
        input[5](input)
      end
  )
end
