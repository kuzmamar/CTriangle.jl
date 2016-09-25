init(::Input, ::TriangulateIO) = error("Implement init method")

get_options(::Input) = error("Implement get_options method")

function triangulate(i::Input)
  input = TriangulateIO()
  output = TriangulateIO()
  voronoi = TriangulateIO()
  options = get_options(i)
  init(i, input)
  ccall(
    (:triangulate, _jl_libtriangle), Void, (Ptr{UInt8}, Ref{TriangulateIO},
    Ref{TriangulateIO}, Ref{TriangulateIO}), , Ref(input),
    Ref(output), Ref(voronoi)
  )
  create_triangulation(output, voronoi)
end
