        #comment
function execute_tests(inputs, handler)
  for input in inputs
    handler(input)
  end
end

@testset "File Names Tests" begin

  inputs = [
    ["./test_files/nodes1.node", CTriangle.NODE_EXT, "./test_files/nodes1"],
    ["./test_files/nodes1", CTriangle.NODE_EXT, "./test_files/nodes1"],
    ["./test_files/nodes1.node", CTriangle.POLY_EXT, "./test_files/nodes1.node"]
  ]

  function handler(input)
    name = CTriangle.remove_extension(input[1], input[2])
    @test name == input[3]
  end

  execute_tests(inputs, handler)

end

@testset "Opening Files Tests" begin

  inputs = [
    ["./test_files/nodes1.node", CTriangle.NodeFileName],
    ["./test_files/nodes1", CTriangle.NodeFileName],
    ["./test_files/pslg1.poly", CTriangle.PolyFileName],
    ["./test_files/pslg1", CTriangle.PolyFileName]
  ]

  function handler(input)
    n = input[2](input[1])
    is = open(n)
    close(is)
    @test isa(is, IOStream) == true
  end

  execute_tests(inputs, handler)

end
