init(::InputInterface, ::InputTriangulateIO) = error("Implement init method")

function init(input::DelaunayFileInput, ioIn::InputTriangulateIO)
    init(input.nodeFile, ioIn)
end

function init(input::ConstrainedDelaunayFileInput, ioIn::InputTriangulateIO)
    init(input.polyFile, ioIn)
end

function init(input::DelaunayRefinementFileInput, ioIn::InputTriangulateIO)
    init(input.nodeFile, ioIn)
    init(input.eleFile, ioIn)
    init(input.areaFile, ioIn)
end

function init(
  input::ConstrainedDelaunayRefinementFileInput, ioIn::InputTriangulateIO
)
    init(input.polyFile, ioIn)
    init(input.eleFile, ioIn)
    init(input.areaFile, ioIn)
end

function init(input::DelaunayUserInput, ioIn::InputTriangulateIO)
    setPoints(ioIn, input.points)
end

getOptions(input::InputInterface) = input.options

function ctriangulate(input::InputInterface)
  ioIn = InputTriangulateIO()
  ioOut = OutputTriangulateIO()
  voronoi = VoronoiTriangulateIO()
  options = getOptions(input)
  init(input, ioIn)
  ccall(
    (:triangulate, _jl_libtriangle), Void, (Ptr{UInt8}, Ref{InputTriangulateIO},
    Ref{OutputTriangulateIO}, Ref{VoronoiTriangulateIO}), options, Ref(ioIn),
    Ref(ioOut), Ref(voronoi)
  )

  (ioOut, voronoi)
end

function triangulate(input::ConstrainedDelaunayRefinementFileInput)
  result::Tuple{OutputTriangulateIO, VoronoiTriangulateIO} = ctriangulate(input)
  ConstrainedDelaunayTriangulation(
    createNodeSection(result[1]),
    createSegmentSection(result[1]),
    NoRegionTriangulationSection(),
    createElementSection(result[1]),
    createEdgeSection(result[1])
  )
end

function triangulate(input::DelaunayRefinementFileInput)
  result::Tuple{OutputTriangulateIO, VoronoiTriangulateIO} = ctriangulate(input)
  DelaunayTriangulation(
    createNodeSection(result[1]),
    createSegmentSection(result[1]),
    createElementSection(result[1]),
    createEdgeSection(result[1])
  )
end

function triangulate(input::ConstrainedDelaunayFileInput)
  result::Tuple{OutputTriangulateIO, VoronoiTriangulateIO} = ctriangulate(input)
  ConstrainedDelaunayTriangulation(
    createNodeSection(result[1]),
    createSegmentSection(result[1]),
    createHoleSection(result[1]),
    createRegionSection(result[1]),
    createElementSection(result[1]),
    createEdgeSection(result[1])
  )
end

function triangulate(input::DelaunayInputInterface)
  result::Tuple{OutputTriangulateIO, VoronoiTriangulateIO} = ctriangulate(input)
  DelaunayTriangulation(
    createNodeSection(result[1]),
    createSegmentSection(result[1]),
    createElementSection(result[1]),
    createEdgeSection(result[1])
  )
end
