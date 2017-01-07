function Base.open(directory::DirectoryInterface, filePath::String)
  open(filePath, "w")
end

function Base.open(directory::FakeDirectory, filePath::String)
  FakeOutputIO()
end

function getNodesDataFilePath(directory::DirectoryInterface)
  getFilePath(directory.directory, directory.nodesDataFileName, DATA_EXT)
end

function getEdgesDataFilePath(directory::DirectoryInterface)
  getFilePath(directory.directory, directory.edgesDataFileName, DATA_EXT)
end

function getElemsDataFilePath(directory::DirectoryInterface)
  getFilePath(directory.directory, directory.elemsDataFileName, DATA_EXT)
end

function getSegmentsDataFilePath(directory::DirectoryInterface)
  getFilePath(directory.directory, directory.segmentsDataFileName, DATA_EXT)
end

function getTriangulationFilePath(directory::Directory)
  getFilePath(directory.directory, directory.triangulationFileName, TRIANGULATION_EXT)
end

function getNodesDataFileName(directory::DirectoryInterface)
  getFileName(directory.nodesDataFileName, DATA_EXT)
end

function getEdgesDataFileName(directory::DirectoryInterface)
  getFileName(directory.edgesDataFileName, DATA_EXT)
end

function getElemsDataFileName(directory::DirectoryInterface)
  getFileName(directory.elemsDataFileName, DATA_EXT)
end

function getSegmentsDataFileName(directory::DirectoryInterface)
  getFileName(directory.segmentsDataFileName, DATA_EXT)
end
