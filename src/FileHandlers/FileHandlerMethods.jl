function readFile(fileHandler::FileHandlerInterface)
  fileStream::FileStreamInterface = createStream(fileHandler,
    open(fileHandler.fileName,
      "$(getName(fileHandler.fileName))$(DOT)$(getExtension(fileHandler.fileName))"
    )
  )
  try
    file::FileInterface = read(fileStream)
  finally
    close(fileStream)
  end
end

function Base.read(fileHandler::FileHandlerInterface)
  readFile(fileHandler)
end

function Base.read(fileHandler::AreaHandler)
  if fileHandler.useAreas
    readFile(fileHandler)
  else
    AreaFile(NoAreaFileSection())
  end
end

createStream(::FileHandlerInterface, ::IO) = error("Implement createStream method.")

function createStream(fileHandler::NodeHandler, fileStream::IO)
  NodeStream(fileStream)
end

function createStream(fileHandler::PolyHandler, fileStream::IO)
  PolyStream(
    fileStream, fileHandler.nodeHandler, fileHandler.useHoles,
    fileHandler.useRegions
  )
end

function createStream(fileHandler::EleHandler, fileStream::IO)
  EleStream(fileStream, fileHandler.startIndex)
end

function createStream(fileHandler::AreaHandler, fileStream::IO)
  AreaStream(fileStream)
end

function setStartIndex(fileHandler::EleHandler, startIndex::Cint)
  fileHandler.startIndex = index
end
