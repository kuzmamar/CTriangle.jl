@testset "Ele File Unit Tests" begin
  inputs = [
    [
      CTriangle.FakeEleName([ # Test that file is read and is empty.
        "0 3 0\n"
      ]),
      Cint(1),
      function(file::CTriangle.EleFile)
        @test isa(file.elementSection, CTriangle.NoElementFileSection) == true
      end
    ],
    [
      CTriangle.FakeEleName([ # Test that file is read with indexing from 0.
        "1 3 0\n",
        "0 0 1 2\n",
      ]),
      Cint(0),
      function(file::CTriangle.EleFile)
        @test [Cint(1), Cint(2), Cint(3)] == file.elementSection.elems
      end
    ],
    [
      CTriangle.FakeEleName([ # Test that file is read with indexing from 1.
        "1 3 0\n",
        "1 1 2 3\n",
      ]),
      Cint(1),
      function(file::CTriangle.EleFile)
        @test [Cint(1), Cint(2), Cint(3)] == file.elementSection.elems
      end
    ],
    [
      CTriangle.FakeEleName([ # Test that file is read with 6 numbers per line.
        "2 6 0\n",
        "1 1 2 3 4 5 6\n",
        "2 7 8 9 10 11 12\n"
      ]),
      Cint(1),
      function(file::CTriangle.EleFile)
        @test [Cint(1), Cint(2), Cint(3),
               Cint(4), Cint(5), Cint(6),
               Cint(7), Cint(8), Cint(9),
               Cint(10), Cint(11), Cint(12)] == file.elementSection.elems
      end
    ],
    [
      CTriangle.FakeEleName([ # Test that file is read with no attributes.
        "2 6 0\n",
        "1 1 2 3 4 5 6\n",
        "2 7 8 9 10 11 12\n"
      ]),
      Cint(1),
      function(file::CTriangle.EleFile)
        @test 0 == length(file.elementSection.attrs)
      end
    ],
    [
      CTriangle.FakeEleName([ # Test that file is read with attributes.
        "2 6 2\n",
        "1 1 2 3 4 5 6 0.1 0.2\n",
        "2 7 8 9 10 11 12 0.3 0.4\n"
      ]),
      Cint(1),
      function(file::CTriangle.EleFile)
        @test [Cdouble(0.1), Cdouble(0.2),
               Cdouble(0.3), Cdouble(0.4)] == file.elementSection.attrs
      end
    ],
  ]

  executeTests(
      inputs,
      function(input)
        input[3](CTriangle.read(CTriangle.EleHandler(input[1], input[2])))
      end
  )
end
