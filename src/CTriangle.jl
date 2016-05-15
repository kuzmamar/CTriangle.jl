module CTriangle

depsjl = joinpath(dirname(@__FILE__), "..", "deps", "deps.jl")
if isfile(depsjl)
	include(depsjl)
else
	error("CTriangle is not properly installed. Please try to run\nPkg.build(\"CTriangle\")")
end


include("Switches.jl")
include("MappedTypes.jl")
include("Iterators.jl")
include("Types.jl")

function truangulate(file::ASCIIString)

end

function truangulate(file::ASCIIString, sw::NodesSwitches)

end

function truangulate(file::ASCIIString, sw::PSLGSwitches)

end

function truangulate(file::ASCIIString, sw::TriangulationSwitches)

end

function truangulate(file::ASCIIString, sw::ConstrainedTriangulationSwitches)

end
