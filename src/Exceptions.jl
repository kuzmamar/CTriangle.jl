abstract CTriangleException <: Exception

immutable EmptyNodeFileException <: CTriangleException end

function Base.showerror(io::IO, e::EmptyNodeFileException)
	print(io, "No points where given. At least three are required.");
end

immutable TriangleNotFoundException <: CTriangleException end

function Base.showerror(io::IO, e::TriangleNotFoundException)
	print(io, "Triangle not found.");
end

immutable NodeNotFoundException <: CTriangleException end

function Base.showerror(io::IO, e::NodeNotFoundException)
	print(io, "Node not found.");
end