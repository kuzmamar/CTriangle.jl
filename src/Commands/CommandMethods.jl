function execute(command::CommandInterface)
  createInput(command)
end

createInput(::CommandInterface) = error("Implement createInput method.")

function createInput(command::DelaunayFileCommand)
  DelaunayFileInput(command.options, read(command.nodeHandler))
end

function createInput(command::ConstrainedDelaunayFileCommand)
  ConstrainedDelaunayFileInput(command.options, read(command.polyHandler))
end

function createInput(command::DelaunayRefinementFileCommand)
  nodeFile::NodeFile = read(command.nodeHandler)
  setStartIndex(command.eleHandler, getStartIndex(nodeFile))
  DelaunayRefinementFileInput(
    command.options,
    nodeFile,
    read(command.eleHandler),
    read(command.areaHandler)
  )
end

function createInput(command::ConstrainedDelaunayRefinementFileCommand)
  polyFile::PolyFile = read(command.polyHandler)
  setStartIndex(command.eleHandler, getStartIndex(polyFile))
  ConstrainedDelaunayRefinementFileInput(
    command.options,
    polyFile,
    read(command.eleHandler),
    read(command.areaHandler)
  )
end
