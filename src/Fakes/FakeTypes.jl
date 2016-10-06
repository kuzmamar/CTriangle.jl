# faked representation of a file for unit tests
type FakeIO <: IO
  lines::Vector{String}
  lineCnt::Int
  lineNumber::Int
  FakeIO(lines::Vector{String}) = new(lines, length(lines), 1)
end

type FakeNodeName <: NodeName
  lines::Vector{String}
end

type FakePolyName <: PolyName
  lines::Vector{String}
end

type FakeEleName <: EleName
  lines::Vector{String}
end

type FakeAreaName <: AreaName
  lines::Vector{String}
end
