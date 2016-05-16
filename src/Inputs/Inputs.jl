abstract AbstractInput

hasedge(i::AbstractInput) = hasedge(i.sw)

hasmarker(i::AbstractInput) = hasmarker(i.sw)

hasconvexhull(i::AbstractInput) = hasconvexhull(i.sw)

hasneighbor(i::AbstractInput) = hasneighbor(i.sw)

function create(i::AbstractInput, io::TriangulateIO)
 Triangulation(createnodes(i, io),
 			   			 createtriangles(i, io),
 			   			 createsegments(i, io),
 			   			 createedges(i, io))
end

function createnodes(i::AbstractInput, io::TriangulateIO)
	Nodes(getpoints(io),
				createpointattrs(i, io),
				createpointmarkers(i, io))
end

function createedges(i::AbstractInput, io::TriangulateIO)
	if hasedge(i) && hasmarker(i)
		Edges(getedges(io), Markers(getedgemarkers(io)))
	elseif hasedge(i)
		Edges(getedges(io), NoMarkers())
	else
		NoEdges()
	end
end

function createsegments(i::AbstractInput, io::TriangulateIO)
	if hasconvexhull(i) && hasmarker(i)
		Segments(getsegments(io), Markers(getsegmentmarkers(io)))
	elseif hasconvexhull(i)
		Segments(getsegments(io), NoMarkers())
	else
		NoSegments()
	end
end

function createtriangles(i::AbstractInput, io::TriangulateIO)
	if hasneighbor(i)
		Triangles(gettriangles(io),
							NoAttributes(),
							Neighbors(getneighbors(io)))
	else
		Triangles(gettriangles(io), NoAttributes(), NoNeighbors())
	end
end

include("NodesInput.jl")

function createpointmarkers(m::AbstractFileMarkers,
													  sw::Switches, io::TriangulateIO)
	NoMarkers()
end

function createsegmentmarkers(m::AbstractFileMarkers,
													    sw::Switches, io::TriangulateIO)
	NoMarkers()
end

function createpointmarkers(m::FileMarkers,
													  sw::Switches, io::TriangulateIO)
	if hasmarker(sw)
		Markes(getpointmarkers(io))
	else
		NoMarkers()
	end
end

function createsegmentmarkers(m::FileMarkers,
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