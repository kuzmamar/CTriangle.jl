type ConstrainedTriangulationSwitches <: AbstractSwitches
  switches::Switches
  function ConstrainedTriangulationSwitches()
    s::Switches = Switches()
    setpoly!(s)
    setjettison!(s)
    setrefinement!(s)
    new(s)
  end
end

function setneighbor!(s::ConstrainedTriangulationSwitches)
  setneighbor!(s.switches)
end

function unsetneighbor!(s::ConstrainedTriangulationSwitches)
  unsetneighbor!(s.switches)
end

function setnomarker!(s::ConstrainedTriangulationSwitches)
  setnomarker!(s.switches)
end

function unsetnomarker!(s::ConstrainedTriangulationSwitches)
  unsetnomarker!(s.switches)
end

function setvaryingmaxarea!(s::ConstrainedTriangulationSwitches)
  setvaryingmaxarea!(s.switches)
end

function unsetvaryingmaxarea!(s::ConstrainedTriangulationSwitches)
  unsetvaryingmaxarea!(s.switches)
end

function setnohole!(s::ConstrainedTriangulationSwitches)
  setnohole!(s.switches)
end

function unsetnohole!(s::ConstrainedTriangulationSwitches)
  unsetnohole!(s.switches)
end

function setminangle!(s::ConstrainedTriangulationSwitches)
  setminangle!(s.switches)
end

function setminangle!(s::ConstrainedTriangulationSwitches, minangle::Float64)
  setminangle!(s.switches, minangle)
end

function unsetminangle!(s::ConstrainedTriangulationSwitches)
  unsetminangle!(s.switches)
end

function setfixedmaxarea!(s::ConstrainedTriangulationSwitches, maxarea::Float64)
  setfixedmaxarea!(s.switches, maxarea)
end

function unsetfixedmaxarea!(s::ConstrainedTriangulationSwitches)
  unsetfixedmaxarea!(s.switches)
end

function setedge!(s::ConstrainedTriangulationSwitches)
  setedge!(s.switches)
end

function unsetedge!(s::ConstrainedTriangulationSwitches)
  unsetedge!(s.switches)
end

function setconvexhull!(s::ConstrainedTriangulationSwitches)
  setconvexhull!(s.switches)
end

function unsetconvexhull!(s::ConstrainedTriangulationSwitches)
  unsetconvexhull!(s.switches)
end
