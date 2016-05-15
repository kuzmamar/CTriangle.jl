module CTriangle

depsjl = joinpath(dirname(@__FILE__), "..", "deps", "deps.jl")
if isfile(depsjl)
	include(depsjl)
else
	error("CTriangle is not properly installed. Please try to run\nPkg.build(\"CTriangle\")")
end

include("TriangulateIO.jl")
include("Switches.jl")
include("MappedTypes.jl")
include("Iterators.jl")
include("Types.jl")
include("Objects/Objects.jl")
include("Loaders/Loaders.jl")

function truangulate(file::ASCIIString)
	triangulate(file, NodesSwitches())
end

function truangulate(file::ASCIIString, sw::NodesSwitches)
	load!(NodesLoader(removeext(file), sw))
end

function truangulate(file::ASCIIString, sw::PSLGSwitches)

end

function truangulate(file::ASCIIString, sw::TriangulationSwitches)

end

function truangulate(file::ASCIIString, sw::ConstrainedTriangulationSwitches)

end

end
