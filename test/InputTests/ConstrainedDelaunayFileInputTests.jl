@testset "Constrained Delaunay File Input Unit Tests" begin
  inputs = [
    [
      CTriangle.FakeNodeName([ # fake node file
        "0 2 0 0\n"
      ]),
      CTriangle.FakePolyName([ # fake node file
        "0 2 0 0\n"
      ]),
      true,
      true,
    ],
  ]

  executeTests(
      inputs,
      function(input)
        cmd = CTriangle.ConstrainedDelaunayFileCommand(
          "",
          input[1],
          input[2],
          input[3],
          input[4]
        )
        # test that input is created
        @test isa(CTriangle.createInput(cmd), CTriangle.ConstrainedDelaunayFileInput) == true
      end
  )
end
