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

getOptions(input::InputInterface) = input.options

function createTriangulation(
	input::InputInterface, ioOut::OutputTriangulateIO,
  voronoi::VoronoiTriangulateIO
)
	error("Implement createTriangulation method.")
end

function createTriangulation(
	input::DelaunayInputInterface, ioOut::OutputTriangulateIO,
  voronoi::VoronoiTriangulateIO
)
	DelaunayTriangulation(
    createNodeSection(ioOut),
    createSegmentSection(ioOut),
    createElementSection(ioOut),
    createEdgeSection(ioOut),
    createNeighborSection(ioOut)
  )
end

function createTriangulation(
	input::ConstrainedDelaunayFileInput, ioOut::OutputTriangulateIO,
  voronoi::VoronoiTriangulateIO
)
	ConstrainedDelaunayTriangulation(
    createNodeSection(ioOut),
    createSegmentSection(ioOut),
    createHoleSection(ioOut),
    createRegionSection(ioOut),
    createElementSection(ioOut),
    createEdgeSection(ioOut),
    createNeighborSection(ioOut)
  )
end

function createTriangulation(
	input::DelaunayRefinementFileInput, ioOut::OutputTriangulateIO,
  voronoi::VoronoiTriangulateIO
)
	DelaunayRefinementTriangulation(
    createNodeSection(ioOut),
    createSegmentSection(ioOut),
    createRegionSection(ioOut),
    createElementSection(ioOut),
    createAreaSection(ioOut),
    createEdgeSection(ioOut),
    createNeighborSection(ioOut)
  )
end

function createTriangulation(
	input::ConstrainedDelaunayRefinementFileInput, ioOut::OutputTriangulateIO,
  voronoi::VoronoiTriangulateIO
)
	DelaunayRefinementTriangulation(
    createNodeSection(ioOut),
    createSegmentSection(ioOut),
    createHoleSection(ioOut),
    createRegionSection(ioOut),
    createElementSection(ioOut),
    createAreaSection(ioOut),
    createEdgeSection(ioOut),
    createNeighborSection(ioOut)
  )
end

function triangulate(input::InputInterface)
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
  createTriangulation(input, ioOut, voronoi)
end
