@testset "Switches Tests" begin
  ns::CTriangle.AbstractSwitches = NodesSwitches()
  s::CTriangle.Switches = getswitches(ns)
  CTriangle.setminangle!(s)
  CTriangle.setfixedmaxarea!(ns, 0.5)
  CTriangle.setminangle!(ns, 28.6)
  @test CTriangle.unsetminangle!(ns) == true
  @test CTriangle.unsetfixedmaxarea!(ns) == true
  CTriangle.setzero!(s)
  CTriangle.setnumbering!(s, Cint(0))
  @test CTriangle.getindex(s, Cint(0)) == Cint(1)
  CTriangle.unsetzero!(s)
  CTriangle.setnumbering!(s, Cint(0)) == Cint(0)
  @test isa(CTriangle.getswitches(s), String)
  CTriangle.setneighbor!(ns)
  CTriangle.setedge!(ns)
  CTriangle.setnomarker!(ns)
  CTriangle.setconvexhull!(ns)
  @test CTriangle.hashole(s) == true
  @test CTriangle.hasneighbor(s) == true
  @test CTriangle.hasedge(s) == true
  @test CTriangle.hasconvexhull(s) == true
end
