abstract CommandInterface

immutable DelaunayFileCommand <: CommandInterface
  options::String
  nodeHandler::NodeHandler
end

immutable ConstrainedDelaunayFileCommand <: CommandInterface
  options::String
  polyHandler::PolyHandler
end

immutable DelaunayRefinementFileCommand <: CommandInterface
  options::String
  nodeHandler::NodeHandler
  eleHandler::EleHandler
  areaHandler::AreaHandler
end

immutable ConstrainedDelaunayRefinementFileCommand <: CommandInterface
  options::String
  polyHandler::PolyHandler
  eleHandler::EleHandler
  areaHandler::AreaHandler
end
