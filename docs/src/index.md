# Introduction to CTriangle

CTriagle works as an interface for [Triangle](https://www.cs.cmu.edu/~quake/triangle.html) library by [Jonathan Shewchuk](https://github.com/JuliaLang/Cairo.jl). Please refer to the triangle site where you can findout more about what you can do with Triangle. Specifically read the following sections.

* [Triangle demonstration](https://www.cs.cmu.edu/~quake/triangle.demo.html)
* input files [.node](https://www.cs.cmu.edu/~quake/triangle.node.html), [.poly](https://www.cs.cmu.edu/~quake/triangle.poly.html), [.area](https://www.cs.cmu.edu/~quake/triangle.area.html) and [.ele](https://www.cs.cmu.edu/~quake/triangle.ele.html).
* [command line switches](https://www.cs.cmu.edu/~quake/triangle.switch.html)

Note that currently generation of the Voronoi diagram is not supported (switch -v) in CTriangle.

CTriangle can also generate graph of given triangulation for Latex package [PGFPlots](http://pgfplots.sourceforge.net/pgfplots.pdf).

## Current status

CTriangle currently runs on Julia versions 0.5.

## Installation and basic usage

Install the package as follows:

```
Pkg.clone("https://github.com/kuzmamar/CTriangle.jl")
Pkg.build("CTriangle.jl")
Pkg.test("CTriangle.jl")
```

and to use it:

```
using CTriangle
```

## Interface for generating triangulations

```@docs
triangulate
```

## Interface for outputing a graph

```@docs
outputGraph
```

## Triangulation interface

Each triangulation implements following functions.

```@docs
getNode
```
```@docs
getNodes
```
```@docs
getSegments
```
```@docs
getElement
```
```@docs
getElements
```
```@docs
getEdges
```
```@docs
getNeighbors
```

Constrained Delaunay triangulations implement also these functions.

```@docs
getHoles
```
```@docs
getRegions
```
