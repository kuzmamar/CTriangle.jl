@testset "Command Unit Tests" begin
  # Test that inputs are created.
  inputs = [
    [
      function(nodeName::Tuple{CTriangle.FakeNodeName},
        params::Tuple{Vararg{Bool}}
      )
        CTriangle.DelaunayFileCommand("", nodeName[1], params...)
      end,
      (CTriangle.FakeNodeName([
        "0 2 0 0\n"
      ]), ),
      (),
      CTriangle.DelaunayFileInput
    ],
    [
      function(fileNames::Tuple{CTriangle.FakeNodeName, CTriangle.FakePolyName},
        params::Tuple{Vararg{Bool}}
      )
        CTriangle.ConstrainedDelaunayFileCommand(
          "", fileNames[1], fileNames[2], params...
        )
      end,
      (CTriangle.FakeNodeName([
        "3 2 0 0\n",
        "1 0 0\n",
        "2 0 1\n",
        "3 1 1\n",
      ]),
      CTriangle.FakePolyName([
        "0 2 0 0\n",
        "1 0\n",
        "1 1 2\n",
        "0\n",
      ])),
      (false, false),
      CTriangle.ConstrainedDelaunayFileInput
    ],
    [
      function(fileNames::Tuple{CTriangle.FakeNodeName, CTriangle.FakeEleName, CTriangle.FakeAreaName},
        params::Tuple{Vararg{Bool}}
      )
        CTriangle.DelaunayRefinementFileCommand(
          "", fileNames[1], fileNames[2], fileNames[3], params...
        )
      end,
      (CTriangle.FakeNodeName([
        "3 2 0 0\n",
        "1 0 0\n",
        "2 0 1\n",
        "3 1 1\n",
      ]),
      CTriangle.FakeEleName([
        "1 3 0\n",
        "1 1 2 3\n",
      ]),
      CTriangle.FakeAreaName([
        "1\n",
        "1 0.4\n",
      ])),
      (true, ),
      CTriangle.DelaunayRefinementFileInput
    ],
    [
      function(fileNames::Tuple{CTriangle.FakeNodeName, CTriangle.FakePolyName, CTriangle.FakeEleName, CTriangle.FakeAreaName},
        params::Tuple{Vararg{Bool}}
      )
        CTriangle.ConstrainedDelaunayRefinementFileCommand(
          "", fileNames[1], fileNames[2], fileNames[3], fileNames[4], params...
        )
      end,
      (CTriangle.FakeNodeName([
        "3 2 0 0\n",
        "1 0 0\n",
        "2 0 1\n",
        "3 1 1\n",
      ]),
      CTriangle.FakePolyName([
        "0 2 0 0\n",
        "3 0\n",
        "1 1 2\n",
        "2 2 3\n",
        "3 1 3\n",
        "1\n",
        "1 1.5 1.5\n",
      ]),
      CTriangle.FakeEleName([
        "1 3 0\n",
        "1 1 2 3\n",
      ]),
      CTriangle.FakeAreaName([
        "1\n",
        "1 0.3\n",
      ])),
      (true, false, true),
      CTriangle.ConstrainedDelaunayRefinementFileInput
    ]
  ]

  executeTests(inputs, function(input)
      command = input[1](input[2], input[3])
      @test isa(CTriangle.createInput(command), input[4])
    end
  )
end
