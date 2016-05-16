abstract AbstractInput

hasedge(i::AbstractInput) = hasedge(i.sw)

hasmarker(i::AbstractInput) = hasmarker(i.sw)

hasconvexhull(i::AbstractInput) = hasconvexhull(i.sw)

function create(i::AbstractInput, io::TriangulateIO)
 Triangulation(create(i, Nodes, io),
 			   			 create(i, Triangles, io),
 			   			 create(i, AbstractSegments, io),
 			   			 create(i, AbstractEdges, io))
end

function create(i::AbstractInput, ::Type{Nodes}, io::TriangulateIO)
	Nodes(getpoints(io),
				createpointattrs(i, io),
				createpointmarkers(i, io))
end

function create(i::AbstractInput, ::Type{AbstractEdges}, io::TriangulateIO)
	if hasedge(i) && hasmarker(i)
		Edges(getedges(io), Markers(getedgemarkers(io))
	elseif hasedge(i)
		Edges(getedges(io), NoMarkers())
	else
		NoEdges()
	end
end

function create(i::AbstractInput, ::Type{AbstractSegments}, io::TriangulateIO)
	if hasconvexhull(i) && hasmarker(i)
		Segments(getsegments(io), Markers(getsegmentmarkers(io)))
	elseif hasconvexhull(i)
		Segments(getsegments(io), NoMarkers())
	else
		NoSegments()
	end
end

function create(i::AbstractInput, ::Type{Triangles}, io::TriangulateIO)
	Triangles(gettriangles(io), NoAttributes())
end

include("NodesInput.jl")

function createpointmarkers(m::AbstractFileMarkers, ::Type{AbstractMarkers},
													  sw::Switches, io::TriangulateIO)
	NoMarkers()
end

function createsegmentmarkers(m::AbstractFileMarkers, ::Type{AbstractMarkers},
													    sw::Switches, io::TriangulateIO)
	NoMarkers()
end

function createpointmarkers(m::FileMarkers, ::Type{AbstractMarkers},
													  sw::Switches, io::TriangulateIO)
	if hasmarker(sw)
		Markes(getpointmarkers(io))
	else
		NoMarkers()
	end
end

function createsegmentmarkers(m::FileMarkers, ::Type{AbstractMarkers},
													    sw::Switches, io::TriangulateIO)
	if hasmarker(sw)
		Markes(getsegmentmarkers(io))
	else
		NoMarkers()
	end
end

function createpointattrs(a::AbstractFileAttributes, io::TriangulateIO)
	NoAttributes()
end

function createtriangleattrs(a::AbstractFileAttributes, io::TriangulateIO)
	NoAttributes()
end

function createpointattrs(a::FileAttributes, io::TriangulateIO)
	Attributes(getpointattrs(io), io.numberofpointattributes)
end

function createtriangleattrs(a::FileAttributes, io::TriangulateIO)
	Attributes(gettriangleattrs(io), io.numberoftriangleattributes)
end