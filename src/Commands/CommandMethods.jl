function execute(command::CommandInterface)
  createInput(command)
end

createInput(::CommandInterface) = error("Implement createInput method.")

function createInput(command::DelaunayFileCommand)
  DelaunayFileInput(
    command.options, read(NodeHandler(NodeName(command.fileName)))
  )
end

function createInput(command::ConstrainedDelaunayFileCommand)
  ConstrainedDelaunayFileInput(command.options, read(
      createPolyHandler(command.fileName, command.useHoles, command.useRegions)
    )
  )
end

function createInput(command::DelaunayRefinementFileCommand)
  nodeFile::NodeFile = read(createNodeHandler(command.fileName))
  eleHandler::EleHandler = createEleHandler(
    command.fileName, getStartIndex(nodeFile)
  )
  areaHandler::AreaHandler = createAreaHandler(
    command.fileName, command.useAreas
  )
  DelaunayRefinementFileInput(
    command.options,
    nodeFile,
    read(eleHandler),
    read(areaHandler)
  )
end

function createInput(command::ConstrainedDelaunayRefinementFileCommand)
  polyFile::PolyFile = read(
    createPolyHandler(command.fileName, command.useHoles, command.useRegions)
  )
  eleHandler::EleHandler = createEleHandler(
    command.fileName, getStartIndex(polyFile)
  )
  areaHandler::AreaHandler = createAreaHandler(
    command.fileName, command.useAreas
  )
  ConstrainedDelaunayRefinementFileInput(
    command.options,
    polyFile,
    read(eleHandler),
    read(areaHandler)
  )
end
