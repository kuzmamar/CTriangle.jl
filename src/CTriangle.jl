module CTriangle

depsjl = joinpath(dirname(@__FILE__), "..", "deps", "deps.jl")
if isfile(depsjl)
	include(depsjl)
else
	error("CTriangle is not properly installed. Please try to run\nPkg.build(\"CTriangle\")")
end

include("Switches.jl")
include("MappedTypes.jl")
include("TriangulateIO.jl")
include("Iterators.jl")
include("Types.jl")
include("Objects/Objects.jl")
include("Files/Files.jl")
include("Loaders/Loaders.jl")
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

function triangulate(file::ASCIIString)
	triangulate(file, NodesSwitches())
end

function triangulate(file::ASCIIString, sw::NodesSwitches)
	ctriangulate(NodesInput(load!(NodesLoader(removeext(file), getswitches(sw))),
						 	 getswitches(sw)))
end

function triangulate(file::ASCIIString, sw::PSLGSwitches)

end

function triangulate(file::ASCIIString, sw::TriangulationSwitches)

end

function triangulate(file::ASCIIString, sw::ConstrainedTriangulationSwitches)

end

export triangulate

end
