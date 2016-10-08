function execute(command::CommandInterface)
  triangulate(createInput(command))
end

createInput(::CommandInterface) = error("Implement createInput method.")

function createInput(command::DelaunayFileCommand)
  DelaunayFileInput(
    command.options, read(createNodeHandler(command.nodeName))
  )
end

function createInput(command::ConstrainedDelaunayFileCommand)
  ConstrainedDelaunayFileInput(command.options, read(
      createPolyHandler(
        command.nodeName, command.polyName, command.useHoles, command.useRegions
      )
    )
  )
end

function createInput(command::DelaunayRefinementFileCommand)
  nodeFile::NodeFile = read(createNodeHandler(command.nodeName))
  eleHandler::EleHandler = createEleHandler(
    command.eleName, getStartIndex(nodeFile)
  )
  areaHandler::AreaHandler = createAreaHandler(
    command.areaName, command.useAreas
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
    createPolyHandler(
      command.nodeName, command.polyName, command.useHoles, command.useRegions
    )
  )
  eleHandler::EleHandler = createEleHandler(
    command.eleName, getStartIndex(polyFile)
  )
  areaHandler::AreaHandler = createAreaHandler(
    command.areaName, command.useAreas
  )
  ConstrainedDelaunayRefinementFileInput(
    command.options,
    polyFile,
    read(eleHandler),
    read(areaHandler)
  )
end

function createInput(command::DelaunayUserCommand)
  DelaunayUserInput(command.options, command.points)
end
