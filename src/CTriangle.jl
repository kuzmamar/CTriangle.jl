module CTriangle

depsjl = joinpath(dirname(@__FILE__), "..", "deps", "deps.jl")

if isfile(depsjl)
	include(depsjl)
else
	error("CTriangle is not properly installed. Please try to run\nPkg.build(\"CTriangle\")")
end

include("Includes.jl")

"""
    triangulate(fileName::String, options::String = "")

# Arguments
* `fileName::String`: the path to the file with or without extension.
* `options::String = ""`: the available options for the triangulations.
"""
function triangulate(fileName::String, options::String = "")
	commandLine::CommandLine = CommandLine()
	execute(
		createCommand(commandLine, parseOptions(commandLine, options), fileName)
	)
end

"""
    triangulate(points::Matrix{Cdouble}, options::String = "")

# Arguments
* `points::Matrix{Cdouble}`: points to be triangulated.
* `options::String = ""`: the available options for the triangulation.
"""
function triangulate(points::Matrix{Cdouble}, options::String = "")
	filteredOptions::String = filterOptions(["r", "p"], options)
	execute(DelaunayUserCommand(
		parseOptions(CommandLine(), filteredOptions), vec(points))
	)
end

"""
    triangulate(points::Matrix{Int}, options::String = "")

# Arguments
* `points::Matrix{Int}`: points to be triangulated.
* `options::String = ""`: the available options for the triangulation.
"""
function triangulate(points::Matrix{Int}, options::String = "")
	triangulate(convert(Matrix{Cdouble}, points), options)
end

function outputGraph(
	triangulation::TriangulationInterface, directory::String;
	nodesDataFileName::String = NODES_OUTPUT_DATA_FILE_NAME,
	edgesDataFileName::String = EDGES_OUTPUT_DATA_FILE_NAME,
	elemesDataFileName::String = ELEMS_OUTPUT_DATA_FILE_NAME,
	segmentsDataFileName::String = SEGMENTS_OUTPUT_DATA_FILE_NAME,
	displayAxis::Bool = false,
	displaySegments::Bool = false
)
	doOutputGraph(
		triangulation,
		Directory(
			directory,
			nodesDataFileName,
			edgesDataFileName,
			elemesDataFileName,
			segmentsDataFileName,
		),
		displayAxis,
		displaySegments
	)
end

export triangulate
export getNode
export getNodes
export getElement
export getElements
export getNeighbors
export getSegments
export getHoles
export getEdges

export outputGraph
export OutputFileNames
export DisplayOptions

end
