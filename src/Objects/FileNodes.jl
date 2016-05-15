abstract AbstractFileNodes <: AbstractObject

type FileNodes <: AbstractFileNodes
  points::Vector{Point}
  a::AbstractFileAttributes
  m::AbstractFileMarkers
end

function initio!(o::FileNodes, io::TriangulateIO)
  setpoints!(io, o.points)
  initio!(o.a, io)
  initio!(o.a, io)
end
