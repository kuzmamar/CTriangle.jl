is_empty(f::NodeFile) = is_empty(f.s)

read(f::File, fs::IOStream) = error("Implement read")

function read(f::NodeFile, fs::IOStream)
  read(f.s, fs)
end

function read(f::PolyFile, fs::IOStream)
  # todo
end
