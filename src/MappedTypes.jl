# Represents a point in 2D.
immutable Point
  x::Cdouble
  y::Cdouble
end

# Represents a triangle, which has indices into Triangle's pointlist vector.
immutable IndexedTriangle
  a::Cint
  b::Cint
  c::Cint
end

function hasindex(t::IndexedTriangle, index::Integer)
	t.a == index || t.b == index || t.c == index
end

function addneighbor!(neighbors::Vector{Cint}, index::Integer, neighbor::Cint)
  if neighbor != index
    push!(neighbors, neighbor)
  end
end

function addneighbors!(t::IndexedTriangle, neighbors::Vector{Cint},
                       index::Integer)
  if hasindex(t, index)
    addneighbor!(neighbors, index, t.a)
    addneighbor!(neighbors, index, t.b)
    addneighbor!(neighbors, index, t.c)
  end
end

# Represents a segment, which has indices into Triangle's pointlist vector.
immutable IndexedSegment
  a::Cint
  b::Cint
end


# Represents neighbors of each triangle.
# It contains indices into Triangle's trianglelist vector.
immutable IndexedTriangleNeighbors
	a::Cint
	b::Cint
	c::Cint
end

function getindexes(n::IndexedTriangleNeighbors)
	ret::Vector{Cint} = Vector{Cint}(length(n))
	j::Cint = 1
	for i::Symbol = Symbol[:a, :b, :c]
		if n.(i) > -1
			ret[j] = n.(i)
			j = j + 1
		end
	end
	ret
end

# Represents a Region
immutable Region
  p::Point
  attr::Cdouble
  maxarea::Cdouble
  function Region(p::Point, attr::Cdouble, maxarea::Cdouble)
    new(p, attr, maxarea)
  end
end

immutable IndexedEdge
  a::Cint
  b::Cint
end
