@testset "File Name Unit Tests" begin
  inputs = [
    ["./test_files/nodes1.node", "./test_files/nodes1"],
    ["./test_files/nodes1", "./test_files/nodes1"],
  ]

  executeTests(inputs, function(input)
      name = CTriangle.removeExtension(input[1])
      @test name == input[2]
    end
  )
end

include("NodeFileTests.jl")
include("PolyFileTests.jl")
include("AreaFileTests.jl")
include("EleFileTests.jl")
