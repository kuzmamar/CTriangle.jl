@testset "Triangulation tests" begin
  s::CTriangle.NodesSwitches = CTriangle.NodesSwitches()
  CTriangle.setneighbor!(s)
  CTriangle.setedge!(s)
  CTriangle.setnomarker!(s)
  t::CTriangle.Triangulation = CTriangle.triangulate("test_files/nodes1", s)
  @test isa(t, CTriangle.Triangulation) == true
end