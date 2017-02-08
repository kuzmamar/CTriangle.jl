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

First argument is a path to input file.
Second argument is a list of command line switches.
Returns desired triangulation.
"""
function triangulate(fileName::String, options::String = "")
	commandLine::CommandLine = CommandLine()
	execute(
		createCommand(commandLine, parseOptions(commandLine, options), fileName)
	)
end

"""
    triangulate(points::Matrix{Cdouble}, options::String = "")

First argument is a matrix of vertices. First row of the matrix are x-cordinates. Second row stores y-coordinates.
Returns Delaunay triangulation.
"""
function triangulate(points::Matrix{Cdouble}, options::String = "")
	filteredOptions::String = filterOptions(["r", "p"], options)
	execute(DelaunayUserCommand(
		parseOptions(CommandLine(), filteredOptions), vec(points))
	)
end

"""
    triangulate(points::Matrix{Int}, options::String = "")

First argument is a matrix of vertices. First row of the matrix are x-cordinates. Second row stores y-coordinates.
Second argument are command line switches.
Returns Delaunay triangulation.
"""
function triangulate(points::Matrix{Int}, options::String = "")
	triangulate(convert(Matrix{Cdouble}, points), options)
end

"""
	outputGraph(
		triangulation::TriangulationInterface, directory::String;
		nodesDataFileName::String = NODES_OUTPUT_DATA_FILE_NAME,
		edgesDataFileName::String = EDGES_OUTPUT_DATA_FILE_NAME,
		elemesDataFileName::String = ELEMS_OUTPUT_DATA_FILE_NAME,
		segmentsDataFileName::String = SEGMENTS_OUTPUT_DATA_FILE_NAME,
		triangulationFileName::String = TRIANGULATION_OUTPUT_FILE_NAME,
		displayAxis::Bool = false
	)

First argument is a triangulation returned form triangulate function.
Second argument is a path to a directory where we want to store the graph in .tex file.
Optionally you can specify name for each .dat file and resulting .tex file.

Argument nodesDataFileName is a name for vertices .dat file.
Argument edgesDataFileName is a name for edges .dat file.
Argument elemesDataFileName is a name for elements (triangles) .dat file.
Argument segmentsDataFileName is a name for segments .dat file.
Argument triangulationFileName is a name for graph .tex file.
Argument displayAxis tells if we want to display axis around the graph.
All .dat files and .tex file will be stored in the given directory.
"""
function outputGraph(
	triangulation::TriangulationInterface, directory::String;
	nodesDataFileName::String = NODES_OUTPUT_DATA_FILE_NAME,
	edgesDataFileName::String = EDGES_OUTPUT_DATA_FILE_NAME,
	elemesDataFileName::String = ELEMS_OUTPUT_DATA_FILE_NAME,
	segmentsDataFileName::String = SEGMENTS_OUTPUT_DATA_FILE_NAME,
	triangulationFileName::String = TRIANGULATION_OUTPUT_FILE_NAME,
	displayAxis::Bool = false
)
	doOutputGraph(
		triangulation,
		Directory(
			directory,
			nodesDataFileName,
			edgesDataFileName,
			elemesDataFileName,
			segmentsDataFileName,
			triangulationFileName
		),
		displayAxis,
		true
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
export getRegions

export outputGraph
export OutputFileNames
export DisplayOptions

end
