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
  io.numberofpointmarkers = Cint(length(markers))
end

function getpoints(io::TriangulateIO)

end

function getpointattrs(io::TriangulateIO)

end

function getpointmarkers(io::TriangulateIO)

end
