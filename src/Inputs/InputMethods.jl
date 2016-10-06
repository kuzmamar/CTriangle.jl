init(::InputInterface, ::InputTriangulateIO) = error("Implement init method")

getOptions(::InputInterface) = error("Implement getOptions method")

function triangulate(input::InputInterface)
  ioIn = InputTriangulateIO()
  ioOut = OutputTriangulateIO()
  voronoi = VoronoiTriangulateIO()
  options = getOptions(input)
  init(input, ioIn)
  ccall(
    (:triangulate, _jl_libtriangle), Void, (Ptr{UInt8}, Ref{TriangulateIO},
    Ref{TriangulateIO}, Ref{TriangulateIO}), Ref(ioIn),
    Ref(ioOut), Ref(voronoi)
  )
  createTriangulation(ioOut, voronoi)
end
