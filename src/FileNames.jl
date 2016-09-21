const NODE_EXT = "node"

const POLY_EXT = "poly"

const DOT = '.'

function remove_extension(filename::String, extension::String)
  if endswith(filename, "$(DOT)$(extension)")
    rsplit(filename, DOT; limit = 2)[1]
  else
    filename
  end
end

abstract FileName

type NodeFileName <: FileName
  filename::String
  NodeFileName(filename::String) = new(remove_extension(filename, NODE_EXT))
end

type PolyFileName <: FileName
  filename::String
  PolyFileName(filename::String) = new(remove_extension(filename, POLY_EXT))
end

get_name(::FileName) = error("Implement get_name method.")

get_extension(::FileName) = error("Implement get_extension method.")

create_stream(::FileName) = error("Implement create_stream method.")

function Base.open(n::FileName)
  create_stream(n, open("$(get_name(n))$(DOT)$(get_extension(n))"))
end

get_name(n::NodeFileName) = n.filename

get_extension(n::NodeFileName) = NODE_EXT

create_stream(n::NodeFileName, s::IOStream) = NodeFileStream(n.filename, s)

get_name(n::PolyFileName) = n.filename

get_extension(n::PolyFileName) = POLY_EXT

create_stream(n::PolyFileName, s::IOStream) = PolyFileStream(n.filename, s)
