const NODE_EXT = "node"

const POLY_EXT = "poly"

const ELE_EXT = "ele"

const AREA_EXT = "area"

const DOT = '.'

abstract FileName

immutable NodeFileName <: FileName
  file_name::String
  read_markers::Bool
  function NodeFileName(file_name::String, read_markers::Bool)
    new(remove_extension(file_name), read_markers)
  end
end

immutable PolyFileName <: FileName
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

immutable EleFileName <: FileName
  file_name::String
  start_index::Cint
  function EleFileName(file_name::String, start_index::Cint)
    new(remove_extension(file_name), start_index)
  end
end

immutable AreaFileName <: FileName
  file_name::String
  AreaFileName(file_name::String) = new(remove_extension(file_name))
end
