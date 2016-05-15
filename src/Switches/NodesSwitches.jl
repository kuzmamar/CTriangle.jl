type NodesSwitches <: AbstractSwitches
  switches::Switches
  function NodesSwitches()
    s::Switches = Switches()
    setjettison!(s)
    new(s)
  end
end

function setneighbor!(s::NodesSwitches)
  setneighbor!(s.switches)
end

function unsetneighbor!(s::NodesSwitches)
  unsetneighbor!(s.switches)
end

function setnomarker!(s::NodesSwitches)
  setnomarker!(s.switches)
end

function unsetnomarker!(s::NodesSwitches)
  unsetnomarker!(s.switches)
end

function setminangle!(s::NodesSwitches)
  setminangle!(s.switches)
end

function setminangle!(s::NodesSwitches, minangle::Float64)
  setminangle!(s.switches, minangle)
end

function unsetminangle!(s::NodesSwitches)
  unsetminangle!(s.switches)
end

function setfixedmaxarea!(s::NodesSwitches, maxarea::Float64)
  setfixedmaxarea!(s.switches, maxarea)
end

function unsetfixedmaxarea!(s::NodesSwitches)
  unsetfixedmaxarea!(s.switches)
end

function setedge!(s::NodesSwitches)
  setedge!(s.switches)
end

function unsetedge!(s::NodesSwitches)
  unsetedge!(s.switches)
end

function setconvexhull!(s::NodesSwitches)
  setconvexhull!(s.switches)
end

function unsetconvexhull!(s::NodesSwitches)
  unsetconvexhull!(s.switches)
end
