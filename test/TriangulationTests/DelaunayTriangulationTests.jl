@testset "Delaunay Triangulation Unit Tests" begin
  inputs = [
    [
      CTriangle.FakeNodeName([ # fake node file
        "2 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
      ]),
      "Q",
      function (input)
        # test that at least 3 vertices must be provided.
        cmd = CTriangle.DelaunayFileCommand(input[2], input[1])
        @test_throws ErrorException CTriangle.execute(cmd)
      end
    ],
    [
      CTriangle.FakeNodeName([ # fake node file
        "3 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
        "2 1 0\n",
      ]),
      "Q",
      function (input)
        # test that triangulation is created
        cmd = CTriangle.DelaunayFileCommand(input[2], input[1])
        @test isa(CTriangle.execute(cmd), CTriangle.DelaunayTriangulation) == true
      end
    ],
    [
      CTriangle.FakeNodeName([ # fake node file
        "3 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
        "2 1 0\n",
      ]),
      "Qn",
      function (input)
        # test that triangulation has neighbors
        cmd = CTriangle.DelaunayFileCommand(input[2], input[1])
        triangulation::CTriangle.DelaunayTriangulation = CTriangle.execute(cmd)
        neighbors::Tuple{Vararg{Cint}} = triangulation.elementSection.neighbors
        @test (length(neighbors) > 0) == true
      end
    ],
    [
      CTriangle.FakeNodeName([ # fake node file
        "3 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
        "2 1 0\n",
      ]),
      "Q",
      function (input)
        # test that triangulation has no neighbors
        cmd = CTriangle.DelaunayFileCommand(input[2], input[1])
        triangulation::CTriangle.DelaunayTriangulation = CTriangle.execute(cmd)
        neighbors::Tuple{Vararg{Cint}} = triangulation.elementSection.neighbors
        @test (length(neighbors) > 0) == false
      end
    ],
    [
      CTriangle.FakeNodeName([ # fake node file
        "3 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
        "2 1 0\n",
      ]),
      "Qe",
      function (input)
        # test that triangulation has edges
        cmd = CTriangle.DelaunayFileCommand(input[2], input[1])
        triangulation::CTriangle.DelaunayTriangulation = CTriangle.execute(cmd)
        @test isa(triangulation.edgeSection, CTriangle.EdgeTriangulationSection) == true
      end
    ],
    [
      CTriangle.FakeNodeName([ # fake node file
        "3 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
        "2 1 0\n",
      ]),
      "Q",
      function (input)
        # test that triangulation has edges
        cmd = CTriangle.DelaunayFileCommand(input[2], input[1])
        triangulation::CTriangle.DelaunayTriangulation = CTriangle.execute(cmd)
        @test isa(triangulation.edgeSection, CTriangle.NoEdgeTriangulationSection) == true
      end
    ],
    [
      CTriangle.FakeNodeName([ # fake node file
        "3 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
        "2 1 0\n",
      ]),
      "Qc",
      function (input)
        # test that triangulation has segments
        cmd = CTriangle.DelaunayFileCommand(input[2], input[1])
        triangulation::CTriangle.DelaunayTriangulation = CTriangle.execute(cmd)
        @test isa(triangulation.segmentSection, CTriangle.SegmentTriangulationSection) == true
      end
    ],
    [
      CTriangle.FakeNodeName([ # fake node file
        "3 2 0 0\n",
        "0 0 0\n",
        "1 0 1\n",
        "2 1 0\n",
      ]),
      "Q",
      function (input)
        # test that triangulation has no segments
        cmd = CTriangle.DelaunayFileCommand(input[2], input[1])
        triangulation::CTriangle.DelaunayTriangulation = CTriangle.execute(cmd)
        @test isa(triangulation.segmentSection, CTriangle.NoSegmentTriangulationSection) == true
      end
    ],
  ]

  executeTests(
      inputs,
      function(input)
        input[3](input)
      end
  )
end
