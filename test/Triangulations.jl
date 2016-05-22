println("Triangulation tests")
s = CTriangle.NodesSwitches()
CTriangle.setneighbor!(s)
CTriangle.setedge!(s)
CTriangle.setnomarker!(s)
t = CTriangle.triangulate("test_files/nodes1", s)
@test isa(t, CTriangle.Triangulation) == true
