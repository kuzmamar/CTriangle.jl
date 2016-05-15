type TriangulationSwitches <: AbstractSwitches
  switches::Switches
  function TriangulationSwitches()
    s::Switches = Switches()
    setjettison!(s)
    setrefinement!(s)
    new(s)
  end
end

function setneighbor!(s::TriangulationSwitches)
  setneighbor!(s.switches)
end

function unsetneighbor!(s::TriangulationSwitches)
  unsetneighbor!(s.switches)
end

function setnomarker!(s::TriangulationSwitches)
  setnomarker!(s.switches)
end

function unsetnomarker!(s::TriangulationSwitches)
  unsetnomarker!(s.switches)
end

function setminangle!(s::TriangulationSwitches)
  setminangle!(s.switches)
end

function setminangle!(s::TriangulationSwitches, minangle::Float64)
  setminangle!(s.switches, minangle)
end

function unsetminangle!(s::TriangulationSwitches)
  unsetminangle!(s.switches)
end

function setfixedmaxarea!(s::TriangulationSwitches, maxarea::Float64)
  setfixedmaxarea!(s.switches, area)
end

function unsetfixedmaxarea!(s::TriangulationSwitches)
  unsetfixedmaxarea!(s.switches)
end

function setvaryingmaxarea!(s::TriangulationSwitches)
  setvaryingmaxarea!(s.switches)
end

function unsetvaryingmaxarea!(s::TriangulationSwitches)
  unsetvaryingmaxarea!(s.switches)
end

function setedge!(s::TriangulationSwitches)
  setedge!(s.switches)
end

function unsetedge!(s::TriangulationSwitches)
  unsetedge!(s.switches)
end

function setconvexhull!(s::TriangulationSwitches)
  setconvexhull!(s.switches)
end

function unsetconvexhull!(s::TriangulationSwitches)
  unsetconvexhull!(s.switches)
end
