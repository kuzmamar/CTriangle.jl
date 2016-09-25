abstract FileStream

type NodeFileStream <: FileStream
  fs::IOStream
  read_markers::Bool
end

type PolyFileStream <: FileStream
  fs::IOStream
  file_name::String
  read_markers::Bool
  read_holes::Bool
  read_regions::Bool
end

type EleFileStream <: FileStream
  fs::IOStream
  start_index::Cint
end

type AreaFileStream <: FileStream
  fs::IOStream
end
