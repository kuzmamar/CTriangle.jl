type TriangulateIO
  pointlist::Ptr{Cdouble}
  pointattributelist::Ptr{Cdouble}
  pointmarkerlist::Ptr{Cint}
  numberofpoints::Cint
  numberofpointattributes::Cint
  trianglelist::Ptr{Cint}
 	triangleattributelist::Ptr{Cdouble}
  trianglearealist::Ptr{Cdouble}
  neighborlist::Ptr{Cint}
  numberoftriangles::Cint
  numberofcorners::Cint
  numberoftriangleattributes::Cint
  segmentlist::Ptr{Cint}
  segmentmarkerlist::Ptr{Cint}
  numberofsegments::Cint
  holelist::Ptr{Cdouble}
  numberofholes::Cint
  regionlist::Ptr{Cdouble}
  numberofregions::Cint
  edgelist::Ptr{Cint}
  edgemarkerlist::Ptr{Cint}
  normlist::Ptr{Cdouble}
  numberofedges::Cint
  TriangulateIO() = new(C_NULL, C_NULL, C_NULL, 0, 0, C_NULL, C_NULL, C_NULL,
                        C_NULL, 0, 0, 0, C_NULL, C_NULL, 0, C_NULL, 0, C_NULL,
                        0, C_NULL, C_NULL, C_NULL, 0)
end

function setpoints!(io::TriangulateIO, points::Vector{Point})
  io.pointlist = reinterpret(Ptr{Cdouble}, pointer(points))
  io.numberofpoints = Cint(length(points))
end

function setpointattrs!(io::TriangulateIO, attrs::Vector{Cdouble},
                        attrcnt::Cint)
  io.pointattributelist = pointer(attrs)
  io.numberofpointattributes = attrcnt
end

function setpointmarkers!(io::TriangulateIO, markers::Vector{Cint})
  io.pointmarkerlist = pointer(markers)
end

function setsegments!(io::TriangulateIO, segments::Vector{IndexedSegment})
  io.segmentlist = reinterpret(Ptr{Cint}, pointer(segments))
  io.numberofsegments = Cint(length(segments))
end

function setsegmentmarkers!(io::TriangulateIO, markers::Vector{Cint})
  io.segmentmarkerlist = pointer(markers)
end

function setholes!(io::TriangulateIO, markers::Vector{Point})
  io.holelist = reinterpret(Ptr{Cdouble}, pointer(markers))
  io.numberofholes = Cint(length(points))
end

function settriangles!(io::TriangulateIO, triangles::Vector{IndexedTriangle})
  io.trianglelist = reinterpret(Ptr{Cint}, pointer(triangles))
  io.numberofcorners = Cint(3)
  io.numberoftriangles = Cint(length(triangles))
end

function settriangleattrs!(io::TriangulateIO, attrs::Vector{Cdouble},
                           attrcnt::Cint)
  io.triangleattributelist = pointer(attrs)
  io.numberoftriangleattributes = attrcnt
end

function setregions!(io::TriangulateIO, regions::Vector{Region})
  io.regionlist = reinterpret(Ptr{Cdouble}, pointer(regions))
end

function setareas!(io::TriangulateIO, areas::Vector{Cdouble})
  io.trianglearealist = pointer(areas)
end

function getpoints(io::TriangulateIO)
  ptr::Ptr{Point} = reinterpret(Ptr{Point}, io.pointlist)
  pointer_to_array(ptr, io.numberofpoints, true)  
end

function getpointattrs(io::TriangulateIO)
  pointer_to_array(io.pointattributelist,
                   io.numberofpoints * io.numberofpointattributes, true)  
end

function getpointmarkers(io::TriangulateIO)
  pointer_to_array(io.pointmarkerlist, io.numberofpoints, true)  
end

function getsegments(io::TriangulateIO)
  ptr::Ptr{IndexedSegment} = reinterpret(Ptr{IndexedSegment}, io.segmentlist)
  pointer_to_array(ptr, io.numberofsegments, true)  
end

function getsegmentmarkers(io::TriangulateIO)
  pointer_to_array(io.segmentmarkerlist, io.numberofsegments, true)  
end

function getedges(io::TriangulateIO)
  ptr::Ptr{IndexedEdge} = reinterpret(Ptr{IndexedEdge}, io.edgelist)
  pointer_to_array(ptr, io.numberofedges, true)  
end

function getedgemarkers(io::TriangulateIO)
  pointer_to_array(io.edgemarkerlist, io.numberofedges, true)  
end

function getholes(io::TriangulateIO)
  ptr::Ptr{Point} = reinterpret(Ptr{Point}, io.holelist)
  pointer_to_array(ptr, io.numberofholes, true)  
end

function getregions(io::TriangulateIO)
  ptr::Ptr{Region} = reinterpret(Ptr{Region}, io.regionlist)
  pointer_to_array(ptr, io.numberofregions, true)  
end

function getareas(io::TriangulateIO)
  pointer_to_array(io.trianglearealist, io.numberoftriangles, true)  
end

function gettriangles(io::TriangulateIO)
  ptr::Ptr{IndexedTriangle} = reinterpret(Ptr{IndexedTriangle}, io.trianglelist)
  pointer_to_array(ptr, io.numberoftriangles, true)  
end


function getneighbors(io::TriangulateIO)
  ptr::Ptr{IndexedTriangleNeighbors} = reinterpret(Ptr{IndexedTriangleNeighbors},
                                                   io.neighborlist)
  pointer_to_array(ptr, io.numberoftriangles, true)  
end