module CTriangle

depsjl = joinpath(dirname(@__FILE__), "..", "deps", "deps.jl")
if isfile(depsjl)
	include(depsjl)
else
	error("CTriangle is not properly installed. Please try to run\nPkg.build(\"CTriangle\")")
end

include("Exceptions.jl")
include("Switches.jl")
include("MappedTypes.jl")
include("TriangulateIO.jl")
include("Iterators.jl")
include("Objects/Objects.jl")
include("Files/Files.jl")
include("Loaders/Loaders.jl")
include("Trangulation/Trangulation.jl")
include("Inputs/Inputs.jl")

function ctriangulate(i::AbstractInput)
	input::TriangulateIO = TriangulateIO()
	output::TriangulateIO = TriangulateIO()
	initio!(i, input)
	ccall((:triangulate, _jl_libtriangle),
 		  Void,
		  (Ptr{UInt8}, Ref{TriangulateIO}, Ref{TriangulateIO}, Ptr{TriangulateIO}),
		  getswitches(i),
		  Ref(input),
		  Ref(output),
		  C_NULL)
	create(i, output)
end

function triangulate(file::String)
	triangulate(file, NodesSwitches())
end

function triangulate(file::String, sw::NodesSwitches)
	ctriangulate(NodesInput(NodeFileLoader(removeext(file), sw)), sw)
end

#==function triangulate(file::String, sw::PSLGSwitches)

end

function triangulate(file::String, sw::TriangulationSwitches)

end

function triangulate(file::String, sw::ConstrainedTriangulationSwitches)

end==#

export triangulate

end
