[![Build Status](https://travis-ci.org/kuzmamar/CTriangle.jl.svg?branch=master)](https://travis-ci.org/kuzmamar/CTriangle.jl)
[![](https://img.shields.io/badge/docs-latest-blue.svg)](https://kuzmamar.github.io/CTriangle.jl/latest)
[![codecov](https://codecov.io/gh/kuzmamar/CTriangle.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/kuzmamar/CTraingle.jl)

#CTriangle
CTriangle is a wrapper around Jonathan Shewchuk's Triangle [library](https://www.cs.cmu.edu/~quake/triangle.html).
At this momment CTriangle is not able to generate Voronoi diagrams.

#Instalation
```julia
julia> Pkg.clone("https://github.com/kuzmamar/CTriangle.jl")
julia> Pkg.build("CTriangle.jl")
julia> Pkg.test("CTriangle.jl")
```
