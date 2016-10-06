#function execute_tests(inputs, handler)
#  for input in inputs
#    handler(input)
#  end
#end

#@testset "File Name Unit Tests" begin

#  inputs = [
#    ["./test_files/nodes1.node", "./test_files/nodes1"],
#    ["./test_files/nodes1", "./test_files/nodes1"],
#  ]

#  function handler(input)
#    name = CTriangle.removeExtension(input[1])
#    @test name == input[2]
#  end

#  execute_tests(inputs, handler)

#end

#@testset "Reading File Unit Tests" begin

#  n = CTriangle.FakeFileName()
#  f = CTriangle.read(n)
#  @test isa(f, CTriangle.File) == true

#end
