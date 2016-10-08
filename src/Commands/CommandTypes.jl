abstract CommandInterface

type DelaunayFileCommand <: CommandInterface
  options::String
  nodeName::NodeNameInterface
end

type ConstrainedDelaunayFileCommand <: CommandInterface
  options::String
  nodeName::NodeNameInterface
  polyName::PolyNameInterface
  useHoles::Bool
  useRegions::Bool
end

type DelaunayRefinementFileCommand <: CommandInterface
  options::String
  nodeName::NodeNameInterface
  eleName::EleNameInterface
  areaName::AreaNameInterface
  useAreas::Bool
end

type ConstrainedDelaunayRefinementFileCommand <: CommandInterface
  options::String
  nodeName::NodeNameInterface
  polyName::PolyNameInterface
  eleName::EleNameInterface
  areaName::AreaNameInterface
  useHoles::Bool
  useRegions::Bool
  useAreas::Bool
end

type DelaunayUserCommand <: CommandInterface
  options::String
  points::Vector{Cdouble}
end
