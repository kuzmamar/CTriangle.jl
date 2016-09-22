abstract FileStream

type NodeFileStream <: FileStream
  fs::IOStream
  read_markers::Bool
end

type PolyFileStream <: FileStream
  file_name::String
  fs::IOStream
  read_markers::Bool
  read_holes::Bool
  read_regions::Bool
end
