@testset "Poly File Unit Tests" begin
  inputs = [
    [
      CTriangle.FakePolyName([ # Test that file is read and is empty.
        "0 2 0 0\n",
        "0 0\n",
        "0\n"
    ]),
    CTriangle.FakeNodeName([
      "0 2 0 0\n"
    ]),
    (false, false),
    function(file::CTriangle.PolyFile)
      @test CTriangle.isEmpty(file.nodeSection) == true
      @test isa(file.segmentSection, CTriangle.NoSegmentFileSection)
      @test isa(file.holeSection, CTriangle.NoHoleFileSection)
      @test isa(file.regionSection, CTriangle.NoRegionFileSection)
    end
    ],
    [
      CTriangle.FakePolyName([ # Test that file is read and is empty even if it has some regions and holes or regions.
        "0 2 0 0\n",
        "2 0\n",
        "1 1\n",
        "2 2\n",
        "1\n",
        "1 0 0\n"
    ]),
    CTriangle.FakeNodeName([
      "0 2 0 0\n"
    ]),
    (true, false),
    function(file::CTriangle.PolyFile)
      @test CTriangle.isEmpty(file.nodeSection) == true
      @test isa(file.segmentSection, CTriangle.NoSegmentFileSection)
      @test isa(file.holeSection, CTriangle.NoHoleFileSection)
      @test isa(file.regionSection, CTriangle.NoRegionFileSection)
    end
    ],
    [
      CTriangle.FakePolyName([ # Test that nodes are read from a different file.
        "0 2 0 0\n",
        "1 0\n",
        "1 1 2\n",
        "0\n"
      ]),
      CTriangle.FakeNodeName([
        "2 2 0 0\n",
        "1 0 0\n",
        "2 1 0\n"
      ]),
      (false, false),
      function(file::CTriangle.PolyFile)
        @test isa(file.nodeSection, CTriangle.NodeFileSection) == true
      end
    ],
    [
      CTriangle.FakePolyName([ # Test that nodes are read from the same file.
        "2 2 0 0\n",
        "1 0 0\n",
        "2 1 0\n",
        "1 0\n",
        "1 1 2\n",
        "0\n"
      ]),
      CTriangle.FakeNodeName([]),
      (false, false),
      function(file::CTriangle.PolyFile)
        @test isa(file.nodeSection, CTriangle.NodeFileSection) == true
      end
    ],
    [
      CTriangle.FakePolyName([ # Test that segments are read.
        "3 2 0 0\n",
        "1 0 0\n",
        "2 1 0\n",
        "3 0 1\n",
        "3 0\n",
        "1 1 2\n",
        "2 2 3\n",
        "3 1 3\n",
        "0\n"
      ]),
      CTriangle.FakeNodeName([]),
      (false, false),
      function(file::CTriangle.PolyFile)
        @test [Cint(1), Cint(2),
               Cint(2), Cint(3),
               Cint(1), Cint(3)] == file.segmentSection.segments
        @test Cint(0) == length(file.segmentSection.markers)
      end
    ],
    [
      CTriangle.FakePolyName([ # Test that segments are read with marker.
        "3 2 0 0\n",
        "1 0 0\n",
        "2 1 0\n",
        "3 0 1\n",
        "3 1\n",
        "1 1 2 1\n",
        "2 2 3 1\n",
        "3 1 3 1\n",
        "0\n"
      ]),
      CTriangle.FakeNodeName([]),
      (false, false),
      function(file::CTriangle.PolyFile)
        @test [Cint(1), Cint(2),
               Cint(2), Cint(3),
               Cint(1), Cint(3)] == file.segmentSection.segments
        @test [Cint(1), Cint(1),
               Cint(1)] == file.segmentSection.markers

      end
    ],
    [
      CTriangle.FakePolyName([ # Test that holes are read.
        "2 2 0 0\n",
        "1 0 0\n",
        "2 1 0\n",
        "1 0\n",
        "1 1 2\n",
        "2\n",
        "1 1 1\n",
        "2 2 2\n",
      ]),
      CTriangle.FakeNodeName([]),
      (true, false),
      function(file::CTriangle.PolyFile)
        @test [Cdouble(1), Cdouble(1),
               Cdouble(2), Cdouble(2)] == file.holeSection.holes
      end
    ],
    [
      CTriangle.FakePolyName([ # Test that no holes are read. We do not want to read them
        "2 2 0 0\n",
        "1 0 0\n",
        "2 1 0\n",
        "1 0\n",
        "1 1 2\n",
        "2\n",
        "1 1 1\n",
        "2 2 2\n",
      ]),
      CTriangle.FakeNodeName([]),
      (false, false),
      function(file::CTriangle.PolyFile)
        @test isa(file.holeSection, CTriangle.SkipHoleFileSection)
      end
    ],
    [
      CTriangle.FakePolyName([ # Test that regions are read with attribute or area.
        "2 2 0 0\n",
        "1 0 0\n",
        "2 1 0\n",
        "1 0\n",
        "1 1 2\n",
        "2\n",
        "1 1 1\n",
        "2 2 2\n",
        "1\n",
        "1 0 0 0.5\n",
      ]),
      CTriangle.FakeNodeName([]),
      (true, true),
      function(file::CTriangle.PolyFile)
        @test [Cdouble(0), Cdouble(0),
               Cdouble(0), Cdouble(0.5)] == file.regionSection.regions
      end
    ],
    [
      CTriangle.FakePolyName([ # Test that regions are read with attribute and area.
        "2 2 0 0\n",
        "1 0 0\n",
        "2 1 0\n",
        "1 0\n",
        "1 1 2\n",
        "2\n",
        "1 1 1\n",
        "2 2 2\n",
        "2\n",
        "1 0 0 0.5 -1\n",
        "2 1 1 0.5 0.4\n",
      ]),
      CTriangle.FakeNodeName([]),
      (true, true),
      function(file::CTriangle.PolyFile)
        @test [Cdouble(0), Cdouble(0),
               Cdouble(0.5), Cdouble(-1),
               Cdouble(1), Cdouble(1),
               Cdouble(0.5), Cdouble(0.4)] == file.regionSection.regions
      end
    ],
    [
      CTriangle.FakePolyName([ # Test that holes are skipped if some holes exist.
        "2 2 0 0\n",
        "1 0 0\n",
        "2 1 0\n",
        "1 0\n",
        "1 1 2\n",
        "2\n",
        "1 1 1\n",
        "2 2 2\n",
        "2\n",
        "1 0 0 0.5 -1\n",
        "2 1 1 0.5 0.4\n",
      ]),
      CTriangle.FakeNodeName([]),
      (false, true),
      function(file::CTriangle.PolyFile)
        @test isa(file.holeSection, CTriangle.SkipHoleFileSection)
        @test isa(file.regionSection, CTriangle.RegionFileSection)
      end
    ],
    [
      CTriangle.FakePolyName([ # Test that holes are skipped if no holes exists.
        "2 2 0 0\n",
        "1 0 0\n",
        "2 1 0\n",
        "1 0\n",
        "1 1 2\n",
        "0\n",
        "2\n",
        "1 0 0 0.5 -1\n",
        "2 1 1 0.5 0.4\n",
      ]),
      CTriangle.FakeNodeName([]),
      (true, true),
      function(file::CTriangle.PolyFile)
        @test isa(file.holeSection, CTriangle.NoHoleFileSection)
        @test isa(file.regionSection, CTriangle.RegionFileSection)
      end
    ],
    [
      CTriangle.FakePolyName([ # Test that regions are skipped if they exist.
        "2 2 0 0\n",
        "1 0 0\n",
        "2 1 0\n",
        "1 0\n",
        "1 1 2\n",
        "2\n",
        "1 1 1\n",
        "2 2 2\n",
        "2\n",
        "1 0 0 0.5 -1\n",
        "2 1 1 0.5 0.4\n",
      ]),
      CTriangle.FakeNodeName([]),
      (true, false),
      function(file::CTriangle.PolyFile)
        @test isa(file.regionSection, CTriangle.NoRegionFileSection)
      end
    ],
    [
      CTriangle.FakePolyName([ # Test that no regions are read even if we want to.
        "2 2 0 0\n",
        "1 0 0\n",
        "2 1 0\n",
        "1 0\n",
        "1 1 2\n",
        "2\n",
        "1 1 1\n",
        "2 2 2\n"
      ]),
      CTriangle.FakeNodeName([]),
      (true, true),
      function(file::CTriangle.PolyFile)
        @test isa(file.regionSection, CTriangle.NoRegionFileSection)
      end
    ],
    [
      CTriangle.FakePolyName([ # Test that holes and regions are skipped.
        "2 2 0 0\n",
        "1 0 0\n",
        "2 1 0\n",
        "1 0\n",
        "1 1 2\n",
        "2\n",
        "1 1 1\n",
        "2 2 2\n",
        "2\n",
        "1 0 0 0.5 -1\n",
        "2 1 1 0.5 0.4\n",
      ]),
      CTriangle.FakeNodeName([]),
      (false, false),
      function(file::CTriangle.PolyFile)
        @test isa(file.holeSection, CTriangle.SkipHoleFileSection)
        @test isa(file.regionSection, CTriangle.NoRegionFileSection)
      end
    ],
  ]

  executeTests(
      inputs,
      function(input)
        fileHandler = CTriangle.PolyHandler(
          input[1],
          CTriangle.NodeHandler(input[2]),
          input[3]...
        )
        input[4](CTriangle.read(fileHandler))
      end
  )
end
