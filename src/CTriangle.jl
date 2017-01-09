module CTriangle

depsjl = joinpath(dirname(@__FILE__), "..", "deps", "deps.jl")

if isfile(depsjl)
	include(depsjl)
else
	error("CTriangle is not properly installed. Please try to run\nPkg.build(\"CTriangle\")")
end

include("Includes.jl")

function triangulate(fileName::String, options::String = "")
	commandLine::CommandLine = CommandLine()
	execute(
		createCommand(commandLine, parseOptions(commandLine, options), fileName)
	)
end

function triangulate(points::Matrix{Cdouble}, options::String = "")
	filteredOptions::String = filterOptions(["r", "p"], options)
	execute(DelaunayUserCommand(
		parseOptions(CommandLine(), filteredOptions), vec(points))
	)
end

function triangulate(points::Matrix{Int}, options::String = "")
	triangulate(convert(Matrix{Cdouble}, points), options)
end

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

export outputGraph
export OutputFileNames
export DisplayOptions

end
