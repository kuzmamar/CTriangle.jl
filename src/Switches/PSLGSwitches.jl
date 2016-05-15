type PSLGSwitches <: AbstractSwitches
  switches::Switches
  function PSLGSwitches()
    s::Switches = Switches()
    setpoly!(s)
    setjettison!(s)
    new(s)
  end
end

function setneighbor!(s::PSLGSwitches)
  setneighbor!(s.switches)
end

function unsetneighbor!(s::PSLGSwitches)
  unsetneighbor!(s.switches)
end

function setnomarker!(s::PSLGSwitches)
  setnomarker!(s.switches)
end

function unsetnomarker!(s::PSLGSwitches)
  unsetnomarker!(s.switches)
end

function setvaryingmaxarea!(s::PSLGSwitches)
  setvaryingmaxarea!(s.switches)
end

function unsetvaryingmaxarea!(s::PSLGSwitches)
  unsetvaryingmaxarea!(s.switches)
end

function setregion!(s::PSLGSwitches)
  setregion!(s.switches)
end

function unsetregion!(s::PSLGSwitches)
  unsetregion!(s.switches)
end

function setnohole!(s::PSLGSwitches)
  setnohole!(s.switches)
end

function unsetnohole!(s::PSLGSwitches)
  unsetnohole!(s.switches)
end

function setminangle!(s::PSLGSwitches)
  setminangle!(s.switches)
end

function setminangle!(s::PSLGSwitches, minangle::Float64)
  setminangle!(s.switches, minangle)
end

function unsetminangle!(s::PSLGSwitches)
  unsetminangle!(s.switches)
end

function setfixedmaxarea!(s::PSLGSwitches, maxarea::Float64)
  setfixedmaxarea!(s.switches, maxarea)
end

function unsetfixedmaxarea!(s::PSLGSwitches)
  unsetfixedmaxarea!(s.switches)
end

function setedge!(s::PSLGSwitches)
  setedge!(s.switches)
end

function unsetedge!(s::PSLGSwitches)
  unsetedge!(s.switches)
end

function setconvexhull!(s::PSLGSwitches)
  setconvexhull!(s.switches)
end

function unsetconvexhull!(s::PSLGSwitches)
  unsetconvexhull!(s.switches)
end
