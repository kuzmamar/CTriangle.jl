getStartIndex(file::NodeFile) = getStartIndex(file.nodeSection)

getStartIndex(file::PolyFile) = getStartIndex(file.nodeSection)

init(::FileInterface, ::InputTriangulateIO) = error("Implement init method.")

function init(file::NodeFile, ioIn::InputTriangulateIO)
  init(file.nodeSection, ioIn)
end

function init(file::PolyFile, ioIn::InputTriangulateIO)
  init(file.nodeSection, ioIn)
  init(file.segmentSection, ioIn)
  init(file.holeSection, ioIn)
  init(file.regionSection, ioIn)
end

function init(file::EleFile, ioIn::InputTriangulateIO)
  init(file.elementSection, ioIn)
end

function init(file::AreaFile, ioIn::InputTriangulateIO)
  init(file.areaSection, ioIn)
end
