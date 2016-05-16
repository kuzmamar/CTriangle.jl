type NodesInput <: AbstractInput
  nf::AbstractNodeFile
  sw::Switches
end

getswitches(i::NodesInput) = getswitches(i.sw)

initio!(i::NodesInput, io::TriangulateIO) = initio!(i.nf, io)

function createpointattrs(i::NodesInput, io::TriangulateIO)
	createpointattrs(i.nf, io)
end

function createpointmarkers(i::NodesInput, io::TriangulateIO)
	createpointmarkers(i.nf, i.sw, io)
end

function createpointattrs(f::NodeFile, io::TriangulateIO)
	createpointattrs(f.a, io::TriangulateIO)
end

function createpointmarkers(f::NodeFile, t::Type{AbstractMarkers}, sw::Switches,
													  io::TriangulateIO)
	createpointmarkers(f.m, sw, io)
end

function createpointattrs(f::NoNodeFile, io::TriangulateIO)
	NoAttributes()
end

function createpointmarkers(f::NoNodeFile, sw::Switches,
														io::TriangulateIO)
	NoMarkers()
end