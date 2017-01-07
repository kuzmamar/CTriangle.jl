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
  if isEmpty(nodeFile) == true
      DelaunayRefinementFileInput(
        command.options,
        nodeFile,
        EleFile(NoElementFileSection()),
        AreaFile(NoAreaFileSection())
      )
  else
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
end

function createInput(command::ConstrainedDelaunayRefinementFileCommand)
  polyFile::PolyFile = read(
    createPolyHandler(
      command.nodeName, command.polyName, command.useHoles, command.useRegions
    )
  )
  if isEmpty(polyFile) == true
    ConstrainedDelaunayRefinementFileInput(
      command.options,
      polyFile,
      EleFile(NoElementFileSection()),
      AreaFile(NoAreaFileSection())
    )
  else
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
end

function createInput(command::DelaunayUserCommand)
  DelaunayUserInput(command.options, command.points)
end
