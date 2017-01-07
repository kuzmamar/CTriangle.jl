type FakeIO <: IO
  lines::Vector{String}
  lineCnt::Int
  lineNumber::Int
  FakeIO(lines::Vector{String}) = new(lines, length(lines), 1)
end

type FakeOutputIO <: IO end

type InputTriangulateIO
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
  InputTriangulateIO() = new(C_NULL, C_NULL, C_NULL, 0, 0, C_NULL, C_NULL, C_NULL,
                        C_NULL, 0, 0, 0, C_NULL, C_NULL, 0, C_NULL, 0, C_NULL,
                        0, C_NULL, C_NULL, C_NULL, 0)
end

type OutputTriangulateIO
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
  OutputTriangulateIO() = new(C_NULL, C_NULL, C_NULL, 0, 0, C_NULL, C_NULL, C_NULL,
                        C_NULL, 0, 0, 0, C_NULL, C_NULL, 0, C_NULL, 0, C_NULL,
                        0, C_NULL, C_NULL, C_NULL, 0)
end

type VoronoiTriangulateIO
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
  VoronoiTriangulateIO() = new(C_NULL, C_NULL, C_NULL, 0, 0, C_NULL, C_NULL, C_NULL,
                        C_NULL, 0, 0, 0, C_NULL, C_NULL, 0, C_NULL, 0, C_NULL,
                        0, C_NULL, C_NULL, C_NULL, 0)
end
