abstract AbstractSwitches

getswitches(s::AbstractSwitches) = s.switches
#test
include("Switches/Switches.jl")
include("Switches/NodesSwitches.jl")
include("Switches/PSLGSwitches.jl")
include("Switches/TriangulationSwitches.jl")
include("Switches/ConstrainedTriangulationSwitches.jl")

export NodesSwitches
export PSLGSwitches
export TriangulationSwitches
export TriangulationSwitches
export ConstrainedTriangulationSwitches

export setneighbor!
export unsetneighbor!
export setnomarker!
export unsetnomarker!
export setvaryingmaxarea!
export unsetvaryingmaxarea!
export setregion!
export unsetregion!
export setnohole!
export unsetnohole!
export setminangle!
export unsetminangle!
export setfixedmaxarea!
export unsetfixedmaxarea!
export setedge!
export unsetedge!
export setconvexhull!
export unsetconvexhull!
export getswitches
