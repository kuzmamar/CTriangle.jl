Base.start(::VectorIteratorInterface) = 1

function Base.next(iterator::VectorIteratorInterface, state::Int)
  (getElement(iterator, state), state + 1)
end

Base.done(iterator::VectorIteratorInterface, state::Int) = state > length(iterator)

Base.eltype(iterator::VectorIteratorInterface) = getElementType(iterator)

Base.length(iterator::VectorIteratorInterface) = 0

Base.length(iterator::NodeIterator) = length(iterator.points) / 2

Base.length(iterator::ElementIterator) = length(iterator.elementSection)

Base.length(iterator::SegmentIterator) = length(iterator.segmentSection)

Base.length(iterator::PointIterator) = length(iterator.points) / 2

Base.length(iterator::EdgeIterator) = length(iterator.edgeSection)

function getElement(iterator::NodeIterator, index::Int)
  createNode(
    iterator.points, iterator.attrs, iterator.attrCnt, iterator.markers, index
  )
end

function getElement(iterator::ElementIterator, index::Int)
  createElement(
    iterator.nodeSection,
    iterator.elementSection,
    iterator.neighborSection,
    index
  )
end

function getElement(iterator::SegmentIterator, index::Int)
  createSegment(iterator.nodeSection, iterator.segmentSection, index)
end

function getElement(iterator::PointIterator, index::Int)
  createPoint(iterator.points, index)
end

function getElement(iterator::EdgeIterator, index::Int)
  createEdge(iterator.nodeSection, iterator.edgeSection, index)
end

getElementType(::NodeIterator) = Node

getElementType(::ElementIterator) = Element

getElementType(::SegmentIterator) = Segment

getElementType(::PointIterator) = Point

getElementType(::EdgeIterator) = Edge
