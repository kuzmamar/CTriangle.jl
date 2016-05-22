type Switches
  zero::Int
  poly::Int
  refinement::Int
  neighbor::Int
  nomarker::Int
  region::Int
  varyingmaxarea::Int
  nohole::Int
  quiet::Int
  jettison::Int
  minangle::Int
  fixedmaxarea::Int
  edge::Int
  convexhull::Int
  switches::Dict{Int, ASCIIString}
  function Switches()
    s::Switches = new(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
                      Dict{Int, ASCIIString}())
    setquiet!(s)
    s
  end
end

function setzero!(s::Switches)
  setswitch!(s, s.zero, "z")
end

function unsetzero!(s::Switches)
  unsetswitch!(s, s.zero)
end

function setjettison!(s::Switches)
  setswitch!(s, s.jettison, "j")
end

function unsetjettison!(s::Switches)
  unsetswitch!(s, s.jettison)
end

function setquiet!(s::Switches)
  setswitch!(s, s.quiet, "Q")
end

function unsetquiet!(s::Switches)
  unsetswitch!(s, s.quiet)
end

function setpoly!(s::Switches)
  setswitch!(s, s.poly, "p")
end

function unsetpoly!(s::Switches)
  unsetswitch!(s, s.poly)
end

function setrefinement!(s::Switches)
  setswitch!(s, s.refinement, "r")
end

function unsetrefinement!(s::Switches)
  unsetswitch!(s, s.refinement)
end

function setneighbor!(s::Switches)
  setswitch!(s, s.neighbor, "n")
end

function unsetneighbor!(s::Switches)
  unsetswitch!(s, s.neighbor)
end

function setnomarker!(s::Switches)
  setswitch!(s, s.nomarker, "B")
end

function unsetnomarker!(s::Switches)
  unsetswitch!(s, s.nomarker)
end

function setvaryingmaxarea!(s::Switches)
  setswitch!(s, s.varyingmaxarea, "a")
end

function unsetvaryingmaxarea!(s::Switches)
  unsetswitch!(s, s.varyingmaxarea)
end

function setnohole!(s::Switches)
  setswitch!(s, s.nohole, "O")
end

function unsetnohole!(s::Switches)
  unsetswitch!(s, s.nohole)
end

function setminangle!(s::Switches)
  setswitch!(s, s.minangle, "q")
end

function setminangle!(s::Switches, minangle::Float64)
  if minangle > 0.0
    setswitch!(s, s.minangle, "q$minangle")
  else
    false
  end
end

function unsetminangle!(s::Switches)
  unsetswitch!(s, s.minangle)
end

function setfixedmaxarea!(s::Switches, maxarea::Float64)
  setswitch!(s, s.fixedmaxarea, "a$maxarea")
end

function unsetfixedmaxarea!(s::Switches)
  unsetswitch!(s, s.fixedmaxarea)
end

function setedge!(s::Switches)
  setswitch!(s, s.edge, "e")
end

function unsetedge!(s::Switches)
  setswitch!(s, s.edge)
end

function setconvexhull!(s::Switches)
  setswitch!(s, s.convexhull, "c")
end

function unsetconvexhull!(s::Switches)
  setswitch!(s, s.convexhull)
end

haszero(s::Switches) = haskey(s.switches, s.zero)

hasvaryingmaxarea(s::Switches) = haskey(s.switches, s.varyingmaxarea)

hashole(s::Switches) = haskey(s.switches, s.nohole) == false

hasreagion(s::Switches) = haskey(s.switches, s.region)

hasneighbor(s::Switches) = haskey(s.switches, s.neighbor)

hasedge(s::Switches) = haskey(s.switches, s.edge)

hasconvexhull(s::Switches) = haskey(s.switches, s.convexhull)

hasmarker(s::Switches) = haskey(s.switches, s.nomarker) == true

function getswitches(s::Switches)
  tmp::Vector{ASCIIString} = Vector{ASCIIString}(length(s.switches))
  i::Int = 1
  for (k::Int, a::ASCIIString) in s.switches
    tmp[i] = a
    i = i + 1
  end
  join(tmp, "")
end

function setswitch!(s::Switches, index::Int, switch::ASCIIString)
  s.switches[index] = switch
end

function unsetswitch!(s::Switches, index::Int)
  if haskey(s.switches, index)
    delete!(s.switches, index)
    true
  else
    false
  end
end

function setnumbering!(s::Switches, index::Cint)
  if index > 0
    unsetzero!(s)
  else
    setzero!(s)
  end
end

function Base.getindex(s::Switches, index::Cint)
  if haszero(s)
    index + Cint(1)
  else
    index
  end
end
