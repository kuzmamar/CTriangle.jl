const NODE_EXT = "node"

const POLY_EXT = "poly"

const DOT = '.'

abstract FileName

type NodeFileName <: FileName
  file_name::String
  read_markers::Bool
  function NodeFileName(file_name::String, read_markers::Bool)
    new(remove_extension(file_name), read_markers)
  end
end

type PolyFileName <: FileName
  file_name::String
  read_markers::Bool
  read_holes::Bool
  read_regions::Bool
  function PolyFileName(
    file_name::String, read_markers::Bool, read_holes::Bool, read_regions::Bool
  )
    new(remove_extension(file_name), read_markers, read_holes, read_regions)
  end
end
