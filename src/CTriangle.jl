module CTriangle

using Combinatorics

depsjl = joinpath(dirname(@__FILE__), "..", "deps", "deps.jl")

if isfile(depsjl)
	include(depsjl)
else
	error("CTriangle is not properly installed. Please try to run\nPkg.build(\"CTriangle\")")
end

import Base.getindex

include("Exceptions.jl")
include("Switches.jl")
include("MappedTypes.jl")
include("TriangulateIO.jl")
include("Iterators.jl")
include("Objects/Objects.jl")
include("Files/Files.jl")
include("Loaders/Loaders.jl")
include("Triangulation/Triangulation.jl")
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

"""
    triangulate(file::String)

Generates a Delaunay triangulation of a set of points.
"""
function triangulate(file::String)
	triangulate(file, NodesSwitches())
end

"""
    triangulate(file::String, sw::NodesSwitches)

Generates a Delaunay triangulation of a set of points.
"""
function triangulate(file::String, sw::NodesSwitches)
	l::NodeFileLoader = NodeFileLoader(removeext(file), getswitches(sw))
	ctriangulate(NodesInput(load!(l), getswitches(sw)))
end

function example()
	s = NodesSwitches()
	setneighbor!(s)
	setedge!(s)
	setconvexhull!(s)
	t = triangulate(joinpath(dirname(@__FILE__), "examples", "example.node"), s)
end

#==function triangulate(file::String, sw::PSLGSwitches)

end

function triangulate(file::String, sw::TriangulationSwitches)

end

function triangulate(file::String, sw::ConstrainedTriangulationSwitches)

end==#

export triangulate

export example

end
