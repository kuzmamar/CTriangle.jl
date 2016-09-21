abstract FileStream

type NodeFileStream <: FileStream
  filename::String
  is::IOStream
end

type PolyFileStream <: FileStream
  filename::String
  is::IOStream
end

get_name(::FileStream) = error("Implement method get_name")

read(::FileStream) = error("Implement method read")

get_name(fs::NodeFileStream) = fs.filename

function read(fs::NodeFileStream)

end

get_name(fs::PolyFileStream) = fs.filename

function read(fs::PolyFileStream)

end
