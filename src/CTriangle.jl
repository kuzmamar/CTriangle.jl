module CTriangle

depsjl = joinpath(dirname(@__FILE__), "..", "deps", "deps.jl")

if isfile(depsjl)
	include(depsjl)
else
	error("CTriangle is not properly installed. Please try to run\nPkg.build(\"CTriangle\")")
end

include("Includes.jl")

function triangulate(fileName::String, options::String)
	commandLine::CommandLine = CommandLine()
	execute(
		createCommand(commandLine, parseOptions(commandLine, options), fileName)
	)
end

#function delaunay(fileName::String)
#	read(NodeFileName(fileName, true))
#end

#function delaunay(fileName::String, ::Options)
#	read(NodeFileName(fileName, true))
#end

#include("Exceptions.jl")
#include("Switches.jl")
#include("MappedTypes.jl")
#include("TriangulateIO.jl")
#include("Iterators.jl")
#include("Objects/Objects.jl")
#include("Files/Files.jl")
#include("Loaders/Loaders.jl")
#include("Triangulation/Triangulation.jl")
#include("Inputs/Inputs.jl")

#function ctriangulate(i::AbstractInput)
#	input::TriangulateIO = TriangulateIO()
#	output::TriangulateIO = TriangulateIO()
#	initio!(i, input)
#	ccall((:triangulate, _jl_libtriangle),
# 		  Void,
#		  (Ptr{UInt8}, Ref{TriangulateIO}, Ref{TriangulateIO}, Ptr{TriangulateIO}),
#		  getswitches(i),
#		  Ref(input),
#		  Ref(output),
#		  C_NULL)
#	create(i, output)
#end

#"""
#    triangulate(file::ASCIIString)

#Generates a Delaunay triangulation of a set of points.
#"""
#function triangulate(file::ASCIIString)
#	triangulate(file, NodesSwitches())
#end

#"""
#    triangulate(file::ASCIIString, sw::NodesSwitches)

#Generates a Delaunay triangulation of a set of points.
#"""
#function triangulate(file::ASCIIString, sw::NodesSwitches)
#	l::NodeFileLoader = NodeFileLoader(removeext(file), getswitches(sw))
#	ctriangulate(NodesInput(load!(l), getswitches(sw)))
#end

#function example()
#	s = NodesSwitches()
#	setneighbor!(s)
#	setedge!(s)
#	setconvexhull!(s)
#	t = triangulate(joinpath(dirname(@__FILE__), "examples", "example.node"), s)
#end

#==function triangulate(file::ASCIIString, sw::PSLGSwitches)

end

function triangulate(file::ASCIIString, sw::TriangulationSwitches)

end

function triangulate(file::ASCIIString, sw::ConstrainedTriangulationSwitches)

end==#

#export triangulate

#export example

end
