"""
    NodesSwitches

A container for specifying options for triangulation.
"""
type NodesSwitches <: AbstractSwitches
  switches::Switches
  function NodesSwitches()
    s::Switches = Switches()
    setjettison!(s)
    new(s)
  end
end

"""
   setneighbor!(s::NodesSwitches) 

Triangulation will contain neighbors for each triangle.
"""
function setneighbor!(s::NodesSwitches)
  setneighbor!(s.switches)
end

"""
   unsetneighbor!(s::NodesSwitches) 

Disallows generating neighbors for each triangle.
"""
function unsetneighbor!(s::NodesSwitches)
  unsetneighbor!(s.switches)
end

"""
   setnomarker!(s::NodesSwitches)

Disallows generation of boundary markers.
"""
function setnomarker!(s::NodesSwitches)
  setnomarker!(s.switches)
end

"""
   unsetnomarker!(s::NodesSwitches)

Boundary markers will be generated.
"""
function unsetnomarker!(s::NodesSwitches)
  unsetnomarker!(s.switches)
end

"""
   setminangle!(s::NodesSwitches, minangle::Float64 = 20.0)

Imposes a minimum angle for each triangle.
"""
function setminangle!(s::NodesSwitches, minangle::Float64 = 20.0)
  setminangle!(s.switches, minangle)
end

"""
   unsetminangle!(s::NodesSwitches)

No min angle constraint will be applied.
"""
function unsetminangle!(s::NodesSwitches)
  unsetminangle!(s.switches)
end

"""
   setfixedmaxarea!(s::NodesSwitches, maxarea::Float64) 

Imposes maximal triangle size for each triangle.
"""
function setfixedmaxarea!(s::NodesSwitches, maxarea::Float64)
  setfixedmaxarea!(s.switches, maxarea)
end

"""
    setfixedmaxarea!(s::NodesSwitches, maxarea::Float64) 

No maximal triangle size constraint will be applied.
"""
function unsetfixedmaxarea!(s::NodesSwitches)
  unsetfixedmaxarea!(s.switches)
end

"""
    setedge!(s::NodesSwitches)

Triangulation will contain edges.
"""
function setedge!(s::NodesSwitches)
  setedge!(s.switches)
end

"""
    unsetedge!(s::NodesSwitches)

Disallows generation of edges.
"""
function unsetedge!(s::NodesSwitches)
  unsetedge!(s.switches)
end

"""
    setconvexhull!(s::NodesSwitches)

Generates convex hull of the triangulation.
"""
function setconvexhull!(s::NodesSwitches)
  setconvexhull!(s.switches)
end

"""
    unsetconvexhull!(s::NodesSwitches)

Disallows generation of convex hull.
"""
function unsetconvexhull!(s::NodesSwitches)
  unsetconvexhull!(s.switches)
end
