if VERSION >= v"0.5.0-dev+7720"
    using Base.Test
else
    using BaseTestNext
    const Test = BaseTestNext
end
using CTriangle

include("Switches.jl")
include("Loaders.jl")
include("Triangulations.jl")
