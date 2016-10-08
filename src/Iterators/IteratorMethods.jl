Base.start(::VectorIteratorInterface) = 1

function Base.next(iterator::VectorIteratorInterface, state::Int)
  (getElement(iterator, state), state + 1)
end

Base.done(iterator::VectorIteratorInterface, state::Int) = state > length(iterator)

Base.eltype(iterator::VectorIteratorInterface) = getElementType(iterator)

Base.length(iterator::VectorIteratorInterface) = 0

Base.length(iterator::NodeIterator) = length(iterator.points) / 2

function getElement(iterator::NodeIterator, index::Int)
  Node(
    createPoint(iterator.points, index),
    createAttrs(iterator.attrs, iterator.attrCnt, index),
    getMarker(iterator.markers, index)
  )
end

getElementType(::NodeIterator) = Node
