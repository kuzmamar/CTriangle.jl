@testset "Loading node file" begin
  s::CTriangle.NodesSwitches = CTriangle.NodesSwitches()
  l::CTriangle.AbstractFileLoader = CTriangle.NodeFileLoader("test_files/nodes1", getswitches(s))
  f::CTriangle.AbstractFile = CTriangle.NoNodeFile()
  for i::Int = 1:6
    l.file = "test_files/nodes$(i)"
    f = CTriangle.load!(l)
    @test isa(f, CTriangle.NodeFile) == true
  end
  l.file = "test_files/nodes7"
  f = CTriangle.load!(l)
  @test isa(f, CTriangle.NoNodeFile) == true
end

#==@testset "Loading Areas" begin
  l::CTriangle.IFileLoader = CTriangle.AreasFileLoader("test_files/areas1")
  areas::CTriangle.IFileAreas = CTriangle.load!(l)
  @test isa(areas, CTriangle.FileAreas) == true
  l.path = "test_files/areas2"
  areas = CTriangle.load!(l)
  @test isa(areas, CTriangle.NoFileAreas) == true
end

@testset "Loading Elements(Triangles)" begin
  s::CTriangle.IFileSwitches = CTriangle.FileNodesSwitches()
  l::CTriangle.IFileLoader = CTriangle.ElementsFileLoader("test_files/elems1", s)
  elems::CTriangle.IFileElements = CTriangle.NoFileElements()
  for i::Int = 1:3
    l.path = "test_files/elems$(i)"
    elems = CTriangle.load!(l)
    @test isa(elems, CTriangle.FileElements) == true
  end
  l.path = "test_files/elems4"
  elems = CTriangle.load!(l)
  @test isa(elems, CTriangle.NoFileElements) == true
  l.path = "test_files/elems5"
  @test_throws(CTriangle.InvalidElementError, CTriangle.load!(l))
end

@testset "Loading PSLG" begin
  s::CTriangle.IFileSwitches = CTriangle.FilePSLGSwitches()
  l::CTriangle.IFileLoader = CTriangle.PSLGFileLoader("test_files/pslg1", s)
  pslg::CTriangle.IFilePSLG = CTriangle.NoFilePSLG()
  for i::Int = 1:3
    l.path = "test_files/pslg$i"
    pslg = CTriangle.load!(l)
    @test isa(pslg, CTriangle.FilePSLG) == true
  end
  setnoholes!(s)
  l.path = "test_files/pslg3"
  pslg = CTriangle.load!(l)
  @test isa(pslg, CTriangle.FilePSLG) == true
  @test isa(pslg.holes, CTriangle.NoFileHoles) == true
  unsetnoholes!(s)
  setregionattr!(s)
  setvaryingarea!(s)
  @test_throws(CTriangle.InvalidRegionArea, CTriangle.load!(l))
  unsetvaryingarea!(s)
  pslg = CTriangle.load!(l)
  @test isa(pslg, CTriangle.FilePSLG) == true
  @test isa(pslg.holes, CTriangle.FileHoles) == true
  @test isa(pslg.regions, CTriangle.FileRegions) == true
end

@testset "Loading Nodes triangulation" begin
  s::CTriangle.IFileSwitches = CTriangle.FileNodesTrigSwitches()
  l::CTriangle.NodesTrigLoader = CTriangle.NodesTrigLoader("test_files/nodes1", s)
  nt::CTriangle.IFileNodesTrig = CTriangle.NoFileNodesTrig()
  nt = CTriangle.load!(l)
  @test isa(nt, CTriangle.FileNodesTrig) == true
end

@testset "Loading PSLG triangulation" begin
  s::CTriangle.IFileSwitches = CTriangle.FilePSLGTrigSwitches()
  l::CTriangle.PSLGTrigLoader = CTriangle.PSLGTrigLoader("test_files/pslg4", s)
  pslgt::CTriangle.IFilePSLGTrig = CTriangle.NoFilePSLGTrig()
  pslgt = CTriangle.load!(l)
  @test isa(pslgt, CTriangle.FilePSLGTrig) == true
end
==#