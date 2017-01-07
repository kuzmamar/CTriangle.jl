function Base.readline(io::FakeIO)
  if eof(io) == true
    return ""
  end
  line = io.lines[io.lineNumber]
  io.lineNumber = io.lineNumber + 1
  return line
end

Base.close(::FakeIO) = return

Base.eof(io::FakeIO) = return io.lineNumber > io.lineCnt

Base.close(::FakeOutputIO) = return

Base.write(::FakeOutputIO, data) = return

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
    ()
  else
    points::Vector{Cdouble} = unsafe_wrap(
      Array, io.pointlist, io.numberofpoints * 2, true
    )
    io.pointlist = C_NULL
    tuple(points...)
  end
end

function getPointAttrs(io::OutputTriangulateIO)
  if io.pointattributelist == C_NULL
    ()
  else
    attrs::Vector{Cdouble} = unsafe_wrap(
      Array,
      io.pointattributelist,
      io.numberofpoints * io.numberofpointattributes,
      true
    )
    io.pointattributelist = C_NULL
    tuple(attrs...)
  end
end

function getPointMarkers(io::OutputTriangulateIO)
  if io.pointmarkerlist == C_NULL
    ()
  else
    markers::Vector{Cint} = unsafe_wrap(
      Array, io.pointmarkerlist, io.numberofpoints, true
    )
    io.pointmarkerlist = C_NULL
    tuple(markers...)
  end
end

function getSegments(io::OutputTriangulateIO)
  if io.segmentlist == C_NULL
    ()
  else
    segments::Vector{Cint} = unsafe_wrap(
      Array, io.segmentlist, io.numberofsegments * 2, true
    )
    io.segmentlist = C_NULL
    tuple(segments...)
  end
end

function getSegmentMarkers(io::OutputTriangulateIO)
  if io.segmentmarkerlist == C_NULL
    ()
  else
    markers::Vector{Cint} = unsafe_wrap(
      Array, io.segmentmarkerlist, io.numberofsegments, true
    )
    io.segmentmarkerlist = C_NULL
    tuple(markers...)
  end
end

function getEdges(io::OutputTriangulateIO)
  if io.edgelist == C_NULL
    ()
  else
    edges::Vector{Cint} = unsafe_wrap(
      Array, io.edgelist, io.numberofedges * 2, true
    )
    io.edgelist = C_NULL
    tuple(edges...)
  end
end

function getEdgeMarkers(io::OutputTriangulateIO)
  if io.edgemarkerlist == C_NULL
    ()
  else
    markers::Vector{Cint} = unsafe_wrap(
      Array, io.edgemarkerlist, io.numberofedges, true
    )
    io.edgemarkerlist = C_NULL
    tuple(markers...)
  end
end

function getHoles(io::OutputTriangulateIO)
  if io.holelist == C_NULL
    ()
  else
    holes::Vector{Cdouble} = unsafe_wrap(
      Array, io.holelist, io.numberofholes * 2, false
    )
    io.holelist = C_NULL
    tuple(holes...)
  end
end

function getRegions(io::OutputTriangulateIO)
  if io.regionlist == C_NULL
    ()
  else
    regions::Vector{Cdouble} = unsafe_wrap(
      Array, io.regionlist, io.numberofregions * 4, false
    )
    io.regionlist = C_NULL
    tuple(regions...)
  end
end

function getElements(io::OutputTriangulateIO)
  if io.trianglelist == C_NULL
    ()
  else
    elems::Vector{Cint} = unsafe_wrap(
      Array, io.trianglelist, io.numberoftriangles * io.numberofcorners, true
    )
    io.trianglelist = C_NULL
    tuple(elems...)
  end
end

function getElementAttrs(io::OutputTriangulateIO)
  if io.triangleattributelist == C_NULL
    ()
  else
    attrs::Vector{Cdouble} = unsafe_wrap(
      Array, io.triangleattributelist,
      io.numberoftriangles * io.numberoftriangleattributes, true
    )
    io.triangleattributelist = C_NULL
    tuple(attrs...)
  end
end

function getNeighbors(io::OutputTriangulateIO)
  if io.neighborlist == C_NULL
    ()
  else
    neighbors::Vector{Cint} = unsafe_wrap(
      Array, io.neighborlist, io.numberoftriangles * 3, true
    )
    io.neighborlist = C_NULL
    tuple(neighbors...)
  end
end

function createNodeSection(io::OutputTriangulateIO)
  points::Tuple{Vararg{Cdouble}} = getPoints(io)
  attrs::Tuple{Vararg{Cdouble}} = getPointAttrs(io)
  markers::Tuple{Vararg{Cint}} = getPointMarkers(io)
  NodeTriangulationSection(points, attrs, io.numberofpointattributes, markers)
end

function createSegmentSection(io::OutputTriangulateIO)
  segments::Tuple{Vararg{Cint}} = getSegments(io)
  if length(segments) == 0
    NoSegmentTriangulationSection()
  else
    markers::Tuple{Vararg{Cint}} = getSegmentMarkers(io)
    SegmentTriangulationSection(segments, markers)
  end
end

function createHoleSection(io::OutputTriangulateIO)
  holes::Tuple{Vararg{Cdouble}} = getHoles(io)
  if length(holes) == 0
    NoHoleTriangulationSection()
  else
    HoleTriangulationSection(holes)
  end
end

function createRegionSection(io::OutputTriangulateIO)
  regions::Tuple{Vararg{Cdouble}} = getRegions(io)
  if length(regions) == 0
    NoRegionTriangulationSection()
  else
    RegionTriangulationSection(regions)
  end
end

function createElementSection(io::OutputTriangulateIO)
  elems::Tuple{Vararg{Cint}} = getElements(io)
  if length(elems) == 0
    NoElementTriangulationSection()
  else
    attrs::Tuple{Vararg{Cdouble}} = getElementAttrs(io)
    neighbors::Tuple{Vararg{Cint}} = getNeighbors(io)
    ElementTriangulationSection(
      elems, io.numberofcorners, attrs, io.numberoftriangleattributes, neighbors
    )
  end
end

function createEdgeSection(io::OutputTriangulateIO)
  edges::Tuple{Vararg{Cint}} = getEdges(io)
  if length(edges) == 0
    NoEdgeTriangulationSection()
  else
    markers::Tuple{Vararg{Cint}} = getEdgeMarkers(io)
    EdgeTriangulationSection(edges, markers)
  end
end
