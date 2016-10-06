abstract CommandInterface

immutable DelaunayFileCommand <: CommandInterface
  options::String
  fileName::String
end

immutable ConstrainedDelaunayFileCommand <: CommandInterface
  options::String
  fileName::String
  useHoles::Bool
  useRegions::Bool
end

immutable DelaunayRefinementFileCommand <: CommandInterface
  options::String
  fileName::String
  useAreas::Bool
end

immutable ConstrainedDelaunayRefinementFileCommand <: CommandInterface
  options::String
  fileName::String
  useHoles::Bool
  useRegions::Bool
  useAreas::Bool
end
