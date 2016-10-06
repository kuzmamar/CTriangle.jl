abstract FileHandlerInterface

type NodeHandler <: FileHandlerInterface
  fileName::NodeNameInterface
end

type PolyHandler <: FileHandlerInterface
  fileName::PolyNameInterface
  nodeHandler::NodeHandler
  useHoles::Bool
  useRegions::Bool
end

type EleHandler <: FileHandlerInterface
  fileName::EleNameInterface
  startIndex::Cint
end

type AreaHandler <: FileHandlerInterface
  fileName::AreaNameInterface
  useAreas::Bool
end
