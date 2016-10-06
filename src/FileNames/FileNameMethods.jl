getExtension(::FileNameInterface) = error("Implement getExtension method.")

getExtension(::NodeNameInterface) = NODE_EXT

getExtension(::PolyNameInterface) = POLY_EXT

getExtension(::EleNameInterface) = ELE_EXT

getExtension(::AreaNameInterface) = AREA_EXT

getName(::FileNameInterface) = error("Implement getName method.")

getName(name::NodeName) = name.fileName

getName(name::FakeNodeName) = "fake_node"

getName(name::PolyName) = name.fileName

getName(name::FakePolyName) = "fake_poly"

getName(name::EleName) = name.fileName

getName(name::FakeEleName) = "fake_ele"

getName(name::AreaName) = name.fileName

getName(name::FakeAreaName) = "fake_area"

function Base.open(::FileNameInterface, fileName::String)
  open(fileName)
end

function Base.open(name::FakeNodeName, fileName::String)
  FakeIO(name.lines)
end

function Base.open(name::FakePolyName, fileName::String)
  FakeIO(name.lines)
end

function Base.open(name::FakeEleName, fileName::String)
  FakeIO(name.lines)
end

function Base.open(name::FakeAreaName, fileName::String)
  FakeIO(name.lines)
end
