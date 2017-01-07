abstract TriangulationSectionOutputInterface

immutable NodeTriangulationSection <: TriangulationSectionOutputInterface
  points::Tuple{Vararg{Cdouble}}
  attrs::Tuple{Vararg{Cdouble}}
  attrCnt::Cint
  markers::Tuple{Vararg{Cint}}
end

abstract SegmentTriangulationSectionInterface <: TriangulationSectionOutputInterface

immutable NoSegmentTriangulationSection <: SegmentTriangulationSectionInterface
end

immutable SegmentTriangulationSection <: SegmentTriangulationSectionInterface
  segments::Tuple{Vararg{Cint}}
  markers::Tuple{Vararg{Cint}}
end

abstract HoleTriangulationSectionInterface

immutable NoHoleTriangulationSection <: HoleTriangulationSectionInterface end

immutable HoleTriangulationSection <: HoleTriangulationSectionInterface
  holes::Tuple{Vararg{Cdouble}}
end

abstract RegionTriangulationSectionInterface

immutable NoRegionTriangulationSection <: RegionTriangulationSectionInterface
end

immutable RegionTriangulationSection <: RegionTriangulationSectionInterface
  regions::Tuple{Vararg{Cdouble}}
end

abstract ElementTriangulationSectionInterface <: TriangulationSectionOutputInterface

immutable NoElementTriangulationSection <: ElementTriangulationSectionInterface
end

immutable ElementTriangulationSection <: ElementTriangulationSectionInterface
  elems::Tuple{Vararg{Cint}}
  cornerCnt::Cint
  attrs::Tuple{Vararg{Cdouble}}
  attrCnt::Cint
  neighbors::Tuple{Vararg{Cint}}
end

abstract EdgeTriangulationSectionInterface <: TriangulationSectionOutputInterface

immutable NoEdgeTriangulationSection <: EdgeTriangulationSectionInterface end

immutable EdgeTriangulationSection <: EdgeTriangulationSectionInterface
  edges::Tuple{Vararg{Cint}}
  markers::Tuple{Vararg{Cint}}
end
