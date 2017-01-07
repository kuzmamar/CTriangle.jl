@testset "Delaunay File Input Unit Tests" begin
  inputs = [
    CTriangle.FakeNodeName([ # fake node file
      "0 2 0 0\n"
    ])
  ]

  executeTests(
      inputs,
      function(input)
        cmd = CTriangle.DelaunayFileCommand("", input)
        @test isa(CTriangle.createInput(cmd), CTriangle.DelaunayFileInput) == true
      end
  )
end
