function getNode(section::NodeTriangulationSection, index::Int)
  Node(
    createPoint(section.points, index),
    createAttrs(section.attrs, section.attrCnt, index),
    getMarker(section.markers, index)
  )
end

function getNodes(section::NodeTriangulationSection)
  # todo
end
