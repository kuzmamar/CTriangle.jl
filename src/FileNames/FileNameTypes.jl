const NODE_EXT = "node"

const POLY_EXT = "poly"

const ELE_EXT = "ele"

const AREA_EXT = "area"

const DOT = '.'

abstract FileNameInterface

abstract NodeNameInterface <: FileNameInterface

immutable NodeName <: NodeNameInterface
  fileName::String
  NodeName(fileName::String) = new(removeExtension(fileName))
end

type FakeNodeName <: NodeNameInterface
  lines::Vector{String}
end

abstract PolyNameInterface <: FileNameInterface

immutable PolyName <: PolyNameInterface
  fileName::String
  PolyName(fileName::String) = new(removeExtension(fileName))
end

type FakePolyName <: PolyNameInterface
  lines::Vector{String}
end

abstract EleNameInterface <: FileNameInterface

immutable EleName <: EleNameInterface
  fileName::String
  startIndex::Cint
  function EleName(fileName::String, startIndex::Cint)
    new(removeExtension(fileName), startIndex)
  end
end

type FakeEleName <: EleNameInterface
  lines::Vector{String}
  startIndex::Cint
end

abstract AreaNameInterface <: FileNameInterface

immutable AreaName <: AreaNameInterface
  fileName::String
  AreaName(fileName::String) = new(removeExtension(fileName))
end

type FakeAreaName <: AreaNameInterface
  lines::Vector{String}
end
