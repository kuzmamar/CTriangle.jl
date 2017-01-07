Base.start(::VectorIteratorInterface) = 1

function Base.next(iterator::VectorIteratorInterface, state::Int)
  (getElement(iterator, state), state + 1)
end

Base.done(iterator::VectorIteratorInterface, state::Int) = state > length(iterator)

Base.eltype(iterator::VectorIteratorInterface) = getElementType(iterator)

Base.length(iterator::VectorIteratorInterface) = 0

Base.length(iterator::NodeIterator) = length(iterator.nodeSection)

Base.length(iterator::ElementIterator) = length(iterator.elementSection)

Base.length(iterator::SegmentIterator) = length(iterator.segmentSection)

Base.length(iterator::HoleIterator) = length(iterator.holeSection)

Base.length(iterator::EdgeIterator) = length(iterator.edgeSection)

Base.length(iterator::RegionIterator) = length(iterator.regionSection)

function getElement(iterator::VectorIteratorInterface, index::Int)
  error("Element of type '$(getElementType(iterator))' not found on index '$(index).'")
end

function getElement(iterator::NodeIterator, index::Int)
  getNode(iterator.nodeSection, index)
end

function getElement(iterator::ElementIterator, index::Int)
  getElement(
    iterator.nodeSection,
    iterator.elementSection,
    index
  )
end

function getElement(iterator::SegmentIterator, index::Int)
  getSegment(iterator.nodeSection, iterator.segmentSection, index)
end

function getElement(iterator::HoleIterator, index::Int)
  getHole(iterator.holeSection, index)
end

function getElement(iterator::EdgeIterator, index::Int)
  getEdge(iterator.nodeSection, iterator.edgeSection, index)
end

function getElement(iterator::RegionIterator, index::Int)
  getRegion(iterator.regionSection, index)
end

getElementType(::NodeIterator) = Node

getElementType(::ElementIterator) = Element

getElementType(::SegmentIterator) = Segment

getElementType(::HoleIterator) = Point

getElementType(::EdgeIterator) = Edge

getElementType(::RegionIterator) = Region
