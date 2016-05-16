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