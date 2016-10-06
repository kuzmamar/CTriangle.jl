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
  io.numberofpointattributes = attrcnt
end

function setPointMarkers(io::InputTriangulateIO, markers::Vector{Cint})
  io.pointmarkerlist = pointer(markers)
end

function setSegments(io::InputTriangulateIO, segments::Vector{Cint})
  io.segmentlist = pointer(segments)
  io.numberofsegments = Cint(length(segments) / 2)
end

function setSegmentMarkers(io::InputTriangulateIO, markers::Vector{Cint})
  io.segmentmarkerlist = pointer(markers)
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
  io.triangleattributelist = pointer(attrs)
  io.numberoftriangleattributes = attrcnt
end

function setRegions(io::InputTriangulateIO, regions::Vector{Cdouble})
  io.regionlist = pointer(regions)
end

function setAreas(io::InputTriangulateIO, areas::Vector{Cdouble})
  io.trianglearealist = pointer(areas)
end

function getPoints(io::OutputTriangulateIO)
  if io.pointlist === C_NULL
    (Cdouble[], Cint(0))
  else
    points = (
      unsafe_wrap(
        Array, io.pointlist, io.numberofpoints * 2, true
      ),
      io.numberofpoints
    )
    io.pointlist = C_NULL
    points
  end
end

function getPointAttrs(io::OutputTriangulateIO)
  if io.pointattributelist === C_NULL
    (Cdouble[], Cint(0), Cint(0))
  else
    attrs = (
      unsafe_wrap(
        Array,
        io.pointattributelist,
        io.numberofpoints * io.numberofpointattributes,
        true
      ),
      io.numberofpoints,
      io.numberofpointattributes
    )
    io.pointattributelist = C_NULL
    attrs
  end
end

function getPointMarkers(io::OutputTriangulateIO)
  if io.pointmarkerlist === C_NULL
    (Cint[], Cint(0))
  else
    markers = (
      unsafe_wrap(
        Array, io.pointmarkerlist, io.numberofpoints, true
      ),
      io.numberofpoints
    )
    io.pointmarkerlist = C_NULL
    markers
  end
end

function getSegments(io::OutputTriangulateIO)
  if io.segmentlist === C_NULL
    (Cint[], Cint(0))
  else
    segments = (
      unsafe_wrap(
        Array, io.segmentlist, io.numberofsegments * 2, true
      ),
      io.numberofsegments
    )
    io.segmentlist = C_NULL
    segments
  end
end

function getSegmentMarkers(io::OutputTriangulateIO)
  if io.segmentmarkerlist === C_NULL
    (Cint[], Cint(0))
  else
    markers = (
      unsafe_wrap(
        Array, io.segmentmarkerlist, io.numberofsegments, true
      ),
      io.numberofsegments
    )
    io.segmentmarkerlist = C_NULL
    markers
  end
end

function getEdges(io::OutputTriangulateIO)
  if io.edgelist === C_NULL
    (Cint[], Cint(0))
  else
    edges = (
      unsafe_wrap(Array, io.edgelist, io.numberofedges, true), io.numberofedges
    )
    io.edgelist = C_NULL
    edges
  end
end

function getEdgeMarkers(io::OutputTriangulateIO)
  if io.edgemarkerlist === C_NULL
    (Cint[], Cint(0))
  else
    markers = (
      unsafe_wrap(
        Array, io.edgemarkerlist, io.numberofedges, true
      ),
      io.numberofedges
    )
    io.edgelist = C_NULL
    markers
  end
end

function getHoles(io::OutputTriangulateIO)
  if io.holelist === C_NULL
    (Cdouble[], Cint(0))
  else
    holes = (
      unsafe_wrap(
        Array, io.holelist, io.numberofholes * 2, true
      ),
      io.numberofholes
    )
    io.holelist = C_NULL
    holes
  end
end

function getRegions(io::OutputTriangulateIO)
  if io.regionlist === C_NULL
    (Cdouble[], Cint(0))
  else
    regions = (
      unsafe_wrap(
        Array, io.regionlist, io.numberofregions * 4, true
      ),
      io.numberofregions
    )
    io.regionlist = C_NULL
    regions
  end
end

function getAreas(io::OutputTriangulateIO)
  if io.trianglearealist === C_NULL
    (Cdouble[], Cint(0))
  else
    areas = (
      unsafe_wrap(
        Array, io.trianglearealist, io.numberoftriangles, true
      ),
      io.numberoftriangles
    )
    io.trianglearealist = C_NULL
    areas
  end
end

function getElements(io::OutputTriangulateIO)
  if io.trianglelist === C_NULL
    (Cint[], Cint(0))
  else
    elems = (
      unsafe_wrap(
        Array, io.trianglelist, io.numberoftriangles * io.numberofcorners, true
      ),
      io.numberoftriangles,
      io.numberofcorners
    )
    io.trianglelist = C_NULL
    elems
  end
end


function getNeighbors(io::OutputTriangulateIO)
  if io.neighborlist === C_NULL
    (Cint[], Cint(0))
  else
    neighbors = (
      unsafe_wrap(
        Array, io.neighborlist, io.numberoftriangles * 3, true
      ),
      io.numberoftriangles
    )
    io.neighborlist = C_NULL
    neighbors
  end
end
