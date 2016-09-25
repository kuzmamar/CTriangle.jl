get_extension(::FileName) = error("Implement get_extension method.")

get_extension(::NodeFileName) = NODE_EXT

get_extension(::PolyFileName) = POLY_EXT

get_extension(::EleFileName) = ELE_EXT

get_extension(::AreaFileName) = AREA_EXT

get_options(::FileName) = ()

get_options(n::NodeFileName) = (n.read_markers)

get_options(n::PolyFileName) = (n.read_markers, n.read_holes, n.read_regions)

function create_stream(::FileName, fs::IOStream, options::Tuple{Vararg{Bool}})
  error("Implement create_stream method")
end

function create_stream(
  n::NodeFileName, fs::IOStream, options::Tuple{Vararg{Bool}}
)
  NodeFileStream(fs, options...)
end

function create_stream(
  n::PolyFileName, fs::IOStream, options::Tuple{Vararg{Bool}}
)
  PolyFileStream(fs, n.filename, options...)
end

function create_stream(
  n::EleFileName, fs::IOStream, options::Tuple{Vararg{Bool}}
)
  EleFileStream(fs, n.start_index, options...)
end

function create_stream(
  n::AreaFileName, fs::IOStream, options::Tuple{Vararg{Bool}}
)
  AreaFileStream(fs, options...)
end

get_name(n::FileName) = n.file_name

function read(n::FileName)
  fs = open(n)
  f = read(fs)
  close(fs)
  f
end

function Base.open(n::FileName)
  create_stream(
    n, open("$(get_name(n))$(DOT)$(get_extension(n))"), get_options(n)...
  )
end
