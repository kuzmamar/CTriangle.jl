using Base.Test, CTriangle

function executeTests(inputs, handler)
  for input in inputs
    handler(input)
  end
end

include("Includes.jl")
