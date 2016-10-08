Base.start(::VectorIteratorInterface) = 1

function Base.next(iterator::VectorIteratorInterface, state::Int)
  (getElement(iterator, state), state + 1)
end

Base.done(iterator::VectorIteratorInterface, state::Int) = state > length(iterator)

Base.eltype(iterator::VectorIteratorInterface) = getElementType(iterator)

Base.length(iterator::VectorIteratorInterface) = 0

Base.length(iterator::NodeIterator) = length(iterator.points) / 2

Base.length(iterator::ElementIterator) = length(iterator.elementSection)

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

getElementType(::NodeIterator) = Node

getElementType(::ElementIterator) = Element
