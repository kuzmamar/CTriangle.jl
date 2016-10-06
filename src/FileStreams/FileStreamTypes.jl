abstract FileStreamInterface

type NodeStream <: FileStreamInterface
  fileStream::IO
end

type PolyStream <: FileStreamInterface
  fileStream::IO
  nodeHandler::NodeHandler
  useHoles::Bool
  useRegions::Bool
end

type EleStream <: FileStreamInterface
  fileStream::IO
end

type AreaStream <: FileStreamInterface
  fileStream::IO
end
