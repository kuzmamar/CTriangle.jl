using Base.Test, CTriangle

# comment
function executeTests(inputs, handler)
  for input in inputs
    handler(input)
  end
end

include("Includes.jl")
