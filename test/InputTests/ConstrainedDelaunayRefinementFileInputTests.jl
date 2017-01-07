@testset "Constrained Delaunay Refinement File Input Unit Tests" begin
  inputs = [
    [
      CTriangle.FakeNodeName([ # fake node file
        "3 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
        "2 1 0\n",
      ]),
      CTriangle.FakePolyName([ # fake poly file
        "0 2 0 0\n",
        "0 0\n",
        "0\n"
      ]),
      CTriangle.FakeEleName([ # fake ele file
        "0 3 0\n"
      ]),
      CTriangle.FakeAreaName([ # fake area file
        "0\n"
      ]),
      true,
      true,
      true,
      function (input)
        cmd = CTriangle.ConstrainedDelaunayRefinementFileCommand(
          "",
          input[1],
          input[2],
          input[3],
          input[4],
          input[5],
          input[6],
          input[7]
        )
        # test that input is created
        @test isa(CTriangle.createInput(cmd), CTriangle.ConstrainedDelaunayRefinementFileInput) == true
      end
    ],
    [
      CTriangle.FakeNodeName([ # fake node file
        "3 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
        "2 1 0\n",
      ]),
      CTriangle.FakePolyName([ # fake poly file
        "0 2 0 0\n",
        "0 0\n",
        "0\n"
      ]),
      CTriangle.FakeEleName([ # fake ele file
        "0 3 0\n"
      ]),
      CTriangle.FakeAreaName([ # fake area file
        "0\n",
      ]),
      true,
      true,
      true,
      function (input)
        cmd = CTriangle.ConstrainedDelaunayRefinementFileCommand(
          "",
          input[1],
          input[2],
          input[3],
          input[4],
          input[5],
          input[6],
          input[7]
        )
        # test that input is created
        @test isa(CTriangle.createInput(cmd), CTriangle.ConstrainedDelaunayRefinementFileInput) == true
      end
    ],
    [
      CTriangle.FakeNodeName([ # fake node file
        "3 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
        "2 1 0\n",
      ]),
      CTriangle.FakePolyName([ # fake poly file
        "0 2 0 0\n",
        "0 0\n",
        "0\n"
      ]),
      CTriangle.FakeEleName([ # fake ele file
        "0 3 0\n"
      ]),
      CTriangle.FakeAreaName([ # fake area file
        "1\n",
        "0 0.4"
      ]),
      true,
      true,
      true,
      function (input)
        cmd = CTriangle.ConstrainedDelaunayRefinementFileCommand(
          "",
          input[1],
          input[2],
          input[3],
          input[4],
          input[5],
          input[6],
          input[7]
        )
        # test that areas are read
        input::CTriangle.ConstrainedDelaunayRefinementFileInput = CTriangle.createInput(cmd)
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
      CTriangle.FakePolyName([ # fake poly file
        "0 2 0 0\n",
        "0 0\n",
        "0\n"
      ]),
      CTriangle.FakeEleName([ # fake ele file
        "0 3 0\n"
      ]),
      CTriangle.FakeAreaName([ # fake area file
        "1\n",
        "0 0.4"
      ]),
      true,
      true,
      false,
      function (input)
        cmd = CTriangle.ConstrainedDelaunayRefinementFileCommand(
          "",
          input[1],
          input[2],
          input[3],
          input[4],
          input[5],
          input[6],
          input[7]
        )
        # test that areas are not read
        input::CTriangle.ConstrainedDelaunayRefinementFileInput = CTriangle.createInput(cmd)
        @test isa(input.areaFile.areaSection, CTriangle.NoAreaFileSection) == true
      end
    ],
  ]

  executeTests(
      inputs,
      function(input)
        input[8](input)
      end
  )
end
