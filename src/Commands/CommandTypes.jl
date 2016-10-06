abstract CommandInterface

immutable DelaunayFileCommand <: CommandInterface
  options::String
  nodeName::NodeNameInterface
end

immutable ConstrainedDelaunayFileCommand <: CommandInterface
  options::String
  nodeName::NodeNameInterface
  polyName::PolyNameInterface
  useHoles::Bool
  useRegions::Bool
end

immutable DelaunayRefinementFileCommand <: CommandInterface
  options::String
  nodeName::NodeNameInterface
  eleName::EleNameInterface
  areaName::AreaNameInterface
  useAreas::Bool
end

immutable ConstrainedDelaunayRefinementFileCommand <: CommandInterface
  options::String
  nodeName::NodeNameInterface
  polyName::PolyNameInterface
  eleName::EleNameInterface
  areaName::AreaNameInterface
  useHoles::Bool
  useRegions::Bool
  useAreas::Bool
end
