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

Base.open(n::FileName) = open("$(get_name(n))$(DOT)$(get_extension(n))")

get_name(n::NodeFileName) = n.filename

get_extension(n::NodeFileName) = NODE_EXT

get_name(n::PolyFileName) = n.filename

get_extension(n::PolyFileName) = POLY_EXT
