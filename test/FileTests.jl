function executeTests(inputs, handler)
  for input in inputs
    handler(input)
  end
end

@testset "File Name Unit Tests" begin
  inputs = [
    ["./test_files/nodes1.node", "./test_files/nodes1"],
    ["./test_files/nodes1", "./test_files/nodes1"],
  ]

  function handler(input)
    name = CTriangle.removeExtension(input[1])
    @test name == input[2]
  end

  executeTests(inputs, handler)

end

@testset "Reading File Unit Tests" begin
  inputs = [
    [
      CTriangle.FakeNodeName([
        "0 2 0 0\n"
      ]), function(file::CTriangle.NodeFile)
            @test isa(file, CTriangle.NodeFile) == true
            @test CTriangle.isEmpty(file.nodeSection) == true
          end
    ],
    [
      CTriangle.FakeNodeName([
        "2 2 0 0\n",
        "1 0 0\n",
        "2 0 1\n"
      ]), function(file::CTriangle.NodeFile)
            @test [Cdouble(0), Cdouble(0),
                   Cdouble(0), Cdouble(1)] == file.nodeSection.points
            @test 0 == length(file.nodeSection.markers)
            @test 0 == length(file.nodeSection.attrs)
          end
    ],
  ]

  function handler(input)
    fileHandler = CTriangle.NodeHandler(input[1])
    file = CTriangle.read(fileHandler)
    input[2](file)
  end

  executeTests(inputs, handler)
end
