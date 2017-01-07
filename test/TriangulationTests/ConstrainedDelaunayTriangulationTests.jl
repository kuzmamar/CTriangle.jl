@testset "Constrained Delaunay Triangulation Unit Tests" begin
  inputs = [
    [
      CTriangle.FakeNodeName([ # fake node file
        "3 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
        "2 1 0\n",
      ]),
      CTriangle.FakePolyName([ # fake node file
        "0 2 0 0\n",
        "0 0\n",
        "0\n",
      ]),
      "Qp",
      true,
      true,
      function (input)
        # test that triangulation is created
        cmd = CTriangle.ConstrainedDelaunayFileCommand(input[3], input[1], input[2], input[4], input[5])
        @test isa(CTriangle.execute(cmd), CTriangle.ConstrainedDelaunayTriangulation) == true
      end
    ],
    [
      CTriangle.FakeNodeName([ # fake node file
        "3 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
        "2 1 0\n",
      ]),
      CTriangle.FakePolyName([ # fake node file
        "0 2 0 0\n",
        "0 0\n",
        "0\n",
      ]),
      "Qp",
      true,
      true,
      function (input)
        # test that triangulation has no segments
        cmd = CTriangle.ConstrainedDelaunayFileCommand(input[3], input[1], input[2], input[4], input[5])
        triangulation::CTriangle.ConstrainedDelaunayTriangulation = CTriangle.execute(cmd)
        @test isa(triangulation.segmentSection, CTriangle.NoSegmentTriangulationSection) == true
      end
    ],
    [
      CTriangle.FakeNodeName([ # fake node file
        "3 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
        "2 1 0\n",
      ]),
      CTriangle.FakePolyName([ # fake node file
        "0 2 0 0\n",
        "0 0\n",
        "0\n",
      ]),
      "Qpc",
      true,
      true,
      function (input)
        # test that triangulation has segments
        cmd = CTriangle.ConstrainedDelaunayFileCommand(input[3], input[1], input[2], input[4], input[5])
        triangulation::CTriangle.ConstrainedDelaunayTriangulation = CTriangle.execute(cmd)
        @test isa(triangulation.segmentSection, CTriangle.NoSegmentTriangulationSection) == false
      end
    ],
    [
      CTriangle.FakeNodeName([ # fake node file
        "3 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
        "2 1 0\n",
      ]),
      CTriangle.FakePolyName([ # fake node file
        "0 2 0 0\n",
        "1 0\n",
        "0 0 1\n",
        "1\n",
        "0 0.5 0.5\n",
        "1\n",
        "0 0.5 0.5 0.5\n",
      ]),
      "Qpac",
      false,
      true,
      function (input)
        # test that triangulation has no holes
        cmd = CTriangle.ConstrainedDelaunayFileCommand(input[3], input[1], input[2], input[4], input[5])
        triangulation::CTriangle.ConstrainedDelaunayTriangulation = CTriangle.execute(cmd)
        @test isa(triangulation.holeSection, CTriangle.NoHoleTriangulationSection) == true
      end
    ],
  ]

  executeTests(
      inputs,
      function(input)
        input[6](input)
      end
  )
end
