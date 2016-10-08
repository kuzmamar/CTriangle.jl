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

function delaunay(points::Matrix{Cdouble}, options::String = "")
	execute(DelaunayUserCommand(
		parseOptions(CommandLine(), options), vec(points))
	)
end

function delaunay(points::Matrix{Int}, options::String = "")
	delaunay(convert(Matrix{Cdouble}, points), options)
end

export triangulate
export delaunay

end
