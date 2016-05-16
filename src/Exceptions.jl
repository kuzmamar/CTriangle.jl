abstract CTriangleException <: Exception

immutable EmptyNodeFileException <: CTriangleException end

function Base.showerror(io::IO, e::EmptyNodeFileException)
	print(io, "No points where given. At least three are required.");
end

immutable TriangleNotFoundException <: CTriangleException
	index::Integer
end

function Base.showerror(io::IO, e::TriangleNotFoundException)
	print(io, "Triangle on index $(e.index) not found.");
end
