@testset "Node File Unit Tests" begin
  inputs = [
    [
      CTriangle.FakeNodeName([ # Test that file is read and is empty.
        "0 2 0 0\n"
      ]),
      function(file::CTriangle.NodeFile)
        @test isa(file, CTriangle.NodeFile) == true
        @test CTriangle.isEmpty(file.nodeSection) == true
      end
    ],
    [
      CTriangle.FakeNodeName([ # Test that points are read with no attributes and no marker.
        "2 2 0 0\n",
        "1 0 0\n",
        "2 0 1\n"
      ]),
      function(file::CTriangle.NodeFile)
        @test [Cdouble(0), Cdouble(0),
               Cdouble(0), Cdouble(1)] == file.nodeSection.points
        @test 0 == length(file.nodeSection.markers)
        @test 0 == length(file.nodeSection.attrs)
      end
    ],
    [
      CTriangle.FakeNodeName([ # Test that points are read with one attribute and no marker.
        "2 2 1 0\n",
        "1 0 0 0.5\n",
        "2 0 1 0.7\n"
      ]),
      function(file::CTriangle.NodeFile)
        @test [Cdouble(0), Cdouble(0),
               Cdouble(0), Cdouble(1)] == file.nodeSection.points
        @test [Cdouble(0.5), Cdouble(0.7)] == file.nodeSection.attrs
        @test 0 == length(file.nodeSection.markers)
      end
    ],
    [
      CTriangle.FakeNodeName([ # Test that points are read with more than one attribute and no marker.
        "2 2 2 0\n",
        "1 0 0 0.5 0.4\n",
        "2 0 1 0.7 0.3\n"
      ]),
      function(file::CTriangle.NodeFile)
        @test [Cdouble(0), Cdouble(0),
               Cdouble(0), Cdouble(1)] == file.nodeSection.points
        @test [Cdouble(0.5), Cdouble(0.4),
               Cdouble(0.7), Cdouble(0.3)] == file.nodeSection.attrs
        @test 0 == length(file.nodeSection.markers)
      end
    ],
    [
      CTriangle.FakeNodeName([ # Test that points are read with attributes and no marker.
        "2 2 2 1\n",
        "1 0 0 0.5 0.4 0\n",
        "2 0 1 0.7 0.3 0\n"
      ]),
      function(file::CTriangle.NodeFile)
        @test [Cdouble(0), Cdouble(0),
               Cdouble(0), Cdouble(1)] == file.nodeSection.points
        @test [Cdouble(0.5), Cdouble(0.4),
               Cdouble(0.7), Cdouble(0.3)] == file.nodeSection.attrs
        @test [Cint(0), Cint(0)] == file.nodeSection.markers
      end
    ],
    [
      CTriangle.FakeNodeName([ # Test that points are read with no attributes and marker.
        "2 2 0 1\n",
        "1 0 0 1\n",
        "2 0 1 2\n"
      ]),
      function(file::CTriangle.NodeFile)
        @test [Cdouble(0), Cdouble(0),
               Cdouble(0), Cdouble(1)] == file.nodeSection.points
        @test 0 == length(file.nodeSection.attrs)
        @test [Cint(1), Cint(2)] == file.nodeSection.markers
      end
    ],
    [
      CTriangle.FakeNodeName([ # Test that indexing starts from 1.
        "1 2 0 0\n",
        "1 0 0\n"
      ]),
      function(file::CTriangle.NodeFile)
        @test Cint(1) == CTriangle.getStartIndex(file)
      end
    ],
    [
      CTriangle.FakeNodeName([ # Test that indexing starts from 0.
        "1 2 0 0\n",
        "0 0 0\n"
      ]),
      function(file::CTriangle.NodeFile)
        @test Cint(0) == CTriangle.getStartIndex(file)
      end
    ],
  ]

  executeTests(
      inputs,
      function(input)
        input[2](CTriangle.read(CTriangle.NodeHandler(input[1])))
      end
  )
end
