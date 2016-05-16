type NodesInput <: AbstractInput
  n::FileNodes
  sw::Switches
end

getswitches(i::NodesInput) = getswitches(i.sw)

initio!(i::NodesInput, io::TriangulateIO) = initio!(i.n, io)

create(i::NodesInput, io::TriangulateIO) = io
