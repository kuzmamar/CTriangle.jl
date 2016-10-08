function getNode(section::NodeTriangulationSection, index::Int)
  Node(
    createPoint(section.points, index),
    createAttrs(section.attrs, section.attrCnt, index),
    getMarker(section.markers, index)
  )
end

function getNodes(section::NodeTriangulationSection)
  NodeIterator(section.points, section.attrs, section.attrCnt, section.markers)
end
