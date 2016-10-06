function Base.readline(io::FakeIO)
  if io.lineNumber > io.lineCnt
    return ""
  end
  line = io.lines[io.lineNumber]
  io.lineNumber = io.lineNumber + 1
  return line
end

Base.close(::FakeIO) = return

Base.open(fileName::FakeNodeName) = FakeIO(fileName.lines)

Base.open(fileName::FakePolyName) = FakeIO(fileName.lines)

Base.open(fileName::FakeEleName) = FakeIO(fileName.lines)

Base.open(fileName::FakeAreaName) = FakeIO(fileName.lines)
