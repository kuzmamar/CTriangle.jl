@testset "Area File Unit Tests" begin
  inputs = [
    [
      CTriangle.FakeAreaName([ # Test that file is read and is empty.
        "0\n"
      ]),
      true,
      function(file::CTriangle.AreaFile)
        @test isa(file.areaSection, CTriangle.NoAreaSection) == true
      end
    ],
    [
      CTriangle.FakeAreaName([ # Test that file is not read.
        "1\n",
        "1 0.5\n"
      ]),
      false,
      function(file::CTriangle.AreaFile)
        @test isa(file.areaSection, CTriangle.NoAreaSection) == true
      end
    ],
    [
      CTriangle.FakeAreaName([ # Test that file is read.
        "2\n",
        "1 0.5\n",
        "2 0.3\n"
      ]),
      true,
      function(file::CTriangle.AreaFile)
        @test [Cdouble(0.5), Cdouble(0.3)] == file.areaSection.areas
      end
    ],
  ]

  executeTests(
      inputs,
      function(input)
        input[3](CTriangle.read(CTriangle.AreaHandler(input[1], input[2])))
      end
  )
end
