is_empty(f::NodeFile) = is_empty(f.s)

read(f::File, fs::IOStream) = error("Implement read")

read(f::NodeFile, fs::IOStream) = read(f.s, fs)

function read(f::PolyFile, fs::IOStream)
  # todo
end
