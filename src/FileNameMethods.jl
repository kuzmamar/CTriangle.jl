function read(n::FileName)
  fs = open(n)
  f = read(fs)
  close(fs)
  f
end

get_name(::FileName) = error("Implement get_name method.")

get_extension(::FileName) = error("Implement get_extension method.")

get_options(::FileName) = ()

get_options(n::NodeFileName) = (n.read_markers)

function Base.open(n::FileName)
  create_stream(
    n, open("$(get_name(n))$(DOT)$(get_extension(n))"), get_options(n)...
  )
end

get_name(n::NodeFileName) = n.file_name

get_extension(n::NodeFileName) = NODE_EXT

function create_stream(n::NodeFileName, s::IOStream, read_markers::Bool)
  NodeFileStream(s, read_markers)
end

get_name(n::PolyFileName) = n.file_name

get_extension(n::PolyFileName) = POLY_EXT

function create_stream(
  n::PolyFileName, s::IOStream, read_markers::Bool, read_holes::Bool,
  read_regions::Bool
)
  PolyFileStream(n.filename, s, read_markers, read_holes, read_regions)
end
