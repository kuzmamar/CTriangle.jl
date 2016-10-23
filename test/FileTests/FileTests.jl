@testset "File Name Unit Tests" begin
  inputs = [
    ["./test_files/nodes1.node", "./test_files/nodes1"], # Test that extension is removed.
    ["./test_files/nodes1", "./test_files/nodes1"], # Test that file name stays the same.
  ]

  executeTests(inputs, function(input)
      name = CTriangle.removeExtension(input[1])
      @test name == input[2]
    end
  )
end

@testset "Skip File Comments and Empty Lines Unit Tests" begin
  fakeIO = CTriangle.FakeIO([ # Test that commented lines and empty are skipped.
    "\n",
    "\n",
    "# first line\n",
    "\n",
    "second line\n",
    "# third line\n",
    "# fourth line\n",
    "fifth line\n",
  ])
  cnt = 0
  while true
    line = CTriangle.readFileLine(fakeIO)
    if 0 == length(line)
      break
    else
      cnt = cnt + 1
    end
  end

  @test 2 == cnt
end

include("NodeFileTests.jl")
include("PolyFileTests.jl")
include("AreaFileTests.jl")
include("EleFileTests.jl")
