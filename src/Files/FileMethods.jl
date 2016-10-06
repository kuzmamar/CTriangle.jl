getStartIndex(file::NodeFile) = getStartIndex(file.nodeSection)

getStartIndex(file::PolyFile) = getStartIndex(file.nodeSection)
