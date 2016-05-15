#Common interface for all iterable vector objects.
abstract IIterable{T}

#All objects must implement Base.length.
Base.length{T}(i::IIterable{T}) = error("$i must implement Base.length.")

Base.start{T}(i::IIterable{T}) = 1

#All objects must implement Base.getindex.
function Base.getindex{T}(i::IIterable{T}, index::Integer)
  error("$i must implement Base.getindex.")
end

Base.next{T}(i::IIterable{T}, index::Int) = (i[index], index + 1)

Base.done{T}(i::IIterable{T}, index::Int) = index > length(i)

Base.eltype{T}(i::IIterable{T}) = T

# common interface for TriangulateIO.pointattributelist or
# TriangulateIO.triangleattributelist
abstract AbstractAttributeIterator <: IIterable{Cdouble}

# Represents an existing TriangulateIO.pointattributelist or
# TriangulateIO.triangleattributelist
type AttributeIterator <: AbstractAttributeIterator
  attrs::Vector{Cdouble}
  first::Int
  last::Int
end

Base.length(i::AttributeIterator) = i.last - i.first + 1

Base.start(i::AttributeIterator) = i.first

Base.getindex(i::AttributeIterator, index::Integer) = i.attrs[index]

Base.done(i::AttributeIterator,  index::Int) = index > length(i.attrs)

# Represents no TriangulateIO.pointattributelist or
# no TriangulateIO.triangleattributelist
immutable NoAttributeIterator <: AbstractAttributeIterator end

Base.length(i::NoAttributeIterator) = 0

Base.getindex(i::NoAttributeIterator, index::Integer) = Cdouble(0.0)

function create(::Type{AttributeIterator}, attrs::Vector{Cdouble},
                attrcnt::Cint, index::Integer)
  last::Int = index * attrcnt
  first::Int = last - attrcnt + 1
  AttributeIterator(attrs, first, last)
end

create(::Type{NoAttributeIterator}) = NoAttributeIterator()

getlength(attrs::Vector{Cdouble}, attrcnt::Cint) = length(attrs) / attrcnt
