# Introduction to CTriangle

CTriagle works as an interface for [Triangle](https://www.cs.cmu.edu/~quake/triangle.html) library by Jonathan Shewchuk.[Jonathan Shewchuk](https://github.com/JuliaLang/Cairo.jl). Please refer to the triangle site where you can findout more about what you can do with Triangle. Specificaly read these sections. 

* [Triangle demonstration](https://www.cs.cmu.edu/~quake/triangle.demo.html)
* input files [.node](https://www.cs.cmu.edu/~quake/triangle.node.html), [.poly](https://www.cs.cmu.edu/~quake/triangle.poly.html), [.area](https://www.cs.cmu.edu/~quake/triangle.area.html) and [.ele](https://www.cs.cmu.edu/~quake/triangle.ele.html).
* [command line switches](https://www.cs.cmu.edu/~quake/triangle.switch.html)

Note that currently generation of the Voronoi diagram is not supported.

CTriangle can also generate graph of given triangulation for Latex package [PGFPlots](http://pgfplots.sourceforge.net/pgfplots.pdf).

## Current status

CTriangle currently runs on Julia versions 0.5.

## Installation and basic usage

Install the package as follows:

```
Pkg.clone("https://github.com/kuzmamar/CTriangle.jl")
```

and to use it:

```
using CTriangle
```

## Interface for generating triangulations

