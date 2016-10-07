function Base.readline(io::FakeIO)
  if io.lineNumber > io.lineCnt
    return ""
  end
  line = io.lines[io.lineNumber]
  io.lineNumber = io.lineNumber + 1
  return line
end

Base.close(::FakeIO) = return

function setPoints(io::InputTriangulateIO, points::Vector{Cdouble})
  io.pointlist = pointer(points)
  io.numberofpoints = Cint(length(points) / 2)
end

function setPointAttrs(io::InputTriangulateIO, attrs::Vector{Cdouble}, attrCnt::Cint)
  io.pointattributelist = pointer(attrs)
  io.numberofpointattributes = attrCnt
end

function setPointMarkers(io::InputTriangulateIO, markers::Vector{Cint})
  if length(markers) > 0
    io.pointmarkerlist = pointer(markers)
  end
end

function setSegments(io::InputTriangulateIO, segments::Vector{Cint})
  io.segmentlist = pointer(segments)
  io.numberofsegments = Cint(length(segments) / 2)
end

function setSegmentMarkers(io::InputTriangulateIO, markers::Vector{Cint})
  if length(markers) > 0
    io.segmentmarkerlist = pointer(markers)
  end
end

function setHoles(io::InputTriangulateIO, holes::Vector{Cdouble})
  io.holelist = pointer(holes)
  io.numberofholes = Cint(length(holes) / 2)
end

function setElements(io::InputTriangulateIO, elements::Vector{Cint}, cornerCnt::Cint)
  io.trianglelist = pointer(elements)
  io.numberofcorners = cornerCnt
  io.numberoftriangles = Cint(length(elements) / cornerCnt)
end

function setElementAttrs(io::InputTriangulateIO, attrs::Vector{Cdouble}, attrCnt::Cint)
  if length(attrs) > 0
    io.triangleattributelist = pointer(attrs)
    io.numberoftriangleattributes = attrCnt
  end
end

function setRegions(io::InputTriangulateIO, regions::Vector{Cdouble})
  io.regionlist = pointer(regions)
end

function setAreas(io::InputTriangulateIO, areas::Vector{Cdouble})
  io.trianglearealist = pointer(areas)
end

function getPoints(io::OutputTriangulateIO)
  if io.pointlist == C_NULL
    Cdouble[]
  else
    points::Vector{Cdouble} = unsafe_wrap(
      Array, io.pointlist, io.numberofpoints * 2, true
    )
    io.pointlist = C_NULL
    points
  end
end

function getPointAttrs(io::OutputTriangulateIO)
  if io.pointattributelist == C_NULL
    Cdouble[]
  else
    attrs::Vector{Cdouble} = unsafe_wrap(
      Array,
      io.pointattributelist,
      io.numberofpoints * io.numberofpointattributes,
      true
    )
    io.pointattributelist = C_NULL
    attrs
  end
end

function getPointMarkers(io::OutputTriangulateIO)
  if io.pointmarkerlist == C_NULL
    Cint[]
  else
    markers::Vector{Cint} = unsafe_wrap(
      Array, io.pointmarkerlist, io.numberofpoints, true
    )
    io.pointmarkerlist = C_NULL
    markers
  end
end

function getSegments(io::OutputTriangulateIO)
  if io.segmentlist == C_NULL
    Cint[]
  else
    segments::Vector{Cint} = unsafe_wrap(
      Array, io.segmentlist, io.numberofsegments * 2, true
    )
    io.segmentlist = C_NULL
    segments
  end
end

function getSegmentMarkers(io::OutputTriangulateIO)
  if io.segmentmarkerlist == C_NULL
    Cint[]
  else
    markers::Vector{Cint} = unsafe_wrap(
      Array, io.segmentmarkerlist, io.numberofsegments, true
    )
    io.segmentmarkerlist = C_NULL
    markers
  end
end

function getEdges(io::OutputTriangulateIO)
  if io.edgelist == C_NULL
    Cint[]
  else
    edges::Vector{Cint} = unsafe_wrap(
      Array, io.edgelist, io.numberofedges * 2, true
    )
    io.edgelist = C_NULL
    edges
  end
end

function getEdgeMarkers(io::OutputTriangulateIO)
  if io.edgemarkerlist == C_NULL
    Cint[]
  else
    markers::Vector{Cint} = unsafe_wrap(
      Array, io.edgemarkerlist, io.numberofedges, true
    )
    io.edgemarkerlist = C_NULL
    markers
  end
end

function getHoles(io::OutputTriangulateIO)
  if io.holelist == C_NULL
    Cdouble[]
  else
    holes::Vector{Cdouble} = unsafe_wrap(
      Array, io.holelist, io.numberofholes * 2, true
    )
    io.holelist = C_NULL
    holes
  end
end

function getRegions(io::OutputTriangulateIO)
  if io.regionlist == C_NULL
    Cdouble[]
  else
    regions::Vector{Cdouble} = unsafe_wrap(
      Array, io.regionlist, io.numberofregions * 4, true
    )
    io.regionlist = C_NULL
    regions
  end
end

function getAreas(io::OutputTriangulateIO)
  if io.trianglearealist == C_NULL
    Cdouble[]
  else
    areas::Vector{Cdouble} = unsafe_wrap(
      Array, io.trianglearealist, io.numberoftriangles, true
    )
    io.trianglearealist = C_NULL
    areas
  end
end

function getElements(io::OutputTriangulateIO)
  if io.trianglelist == C_NULL
    Cint[]
  else
    elems::Vector{Cint} = unsafe_wrap(
      Array, io.trianglelist, io.numberoftriangles * io.numberofcorners, true
    )
    io.trianglelist = C_NULL
    elems
  end
end

function getElementAttrs(io::OutputTriangulateIO)
  if io.triangleattributelist == C_NULL
    Cdouble[]
  else
    attrs::Vector{Cdouble} = unsafe_wrap(
      Array, io.triangleattributelist,
      io.numberoftriangles * io.numberoftriangleattributes, true
    )
    io.triangleattributelist = C_NULL
    attrs
  end
end


function getNeighbors(io::OutputTriangulateIO)
  if io.neighborlist == C_NULL
    Cint[]
  else
    neighbors::Vector{Cint} = unsafe_wrap(
      Array, io.neighborlist, io.numberoftriangles * 3, true
    )
    io.neighborlist = C_NULL
    neighbors
  end
end

function createNodeSection(io::OutputTriangulateIO)
  points::Vector{Cdouble} = getPoints(io)
  attrs::Vector{Cdouble} = getPointAttrs(io)
  markers::Vector{Cint} = getPointMarkers(io)
  NodeTriangulationSection(points, attrs, io.numberofpointattributes, markers)
end

function createSegmentSection(io::OutputTriangulateIO)
  segments::Vector{Cint} = getSegments(io)
  if length(segments) == 0
    NoSegmentTriangulationSection()
  else
    markers::Vector{Cint} = getSegmentMarkers(io)
    SegmentTriangulationSection(segments, markers)
  end
end

function createHoleSection(io::OutputTriangulateIO)
  holes::Vector{Cdouble} = getHoles(io)
  if length(holes) == 0
    NoHoleTriangulationSection()
  else
    HoleTriangulationSection(holes)
  end
end

function createRegionSection(io::OutputTriangulateIO)
  regions::Vector{Cdouble} = getRegions(io)
  if length(regions) == 0
    NoRegionTriangulationSection()
  else
    RegionTriangulationSection(regions)
  end
end

function createElementSection(io::OutputTriangulateIO)
  elems::Vector{Cint} = getElements(io)
  if length(elems) == 0
    NoElementTriangulationSection()
  else
    attrs::Vector{Cdouble} = getElementAttrs(io)
    ElementTriangulationSection(
      elems, io.numberofcorners, attrs, io.numberoftriangleattributes
    )
  end
end

function createAreaSection(io::OutputTriangulateIO)
  areas::Vector{Cdouble} = getAreas(io)
  if length(areas) == 0
    NoAreaTriangulationSection()
  else
    AreaTriangulationSection(areas)
  end
end

function createEdgeSection(io::OutputTriangulateIO)
  edges::Vector{Cint} = getEdges(io)
  if length(edges) == 0
    NoEdgeTriangulationSection()
  else
    markers::Vector{Cint} = getEdgeMarkers(io)
    EdgeTriangulationSection(edges, markers)
  end
end

function createNeighborSection(io::OutputTriangulateIO)
  neighbors::Vector{Cint} = getNeighbors(io)
  if length(neighbors) == 0
    NoNeighborTriangulationSection()
  else
    NeighborTriangulationSection(neighbors)
  end
end
