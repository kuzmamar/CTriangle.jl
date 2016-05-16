abstract AbstractNodeFileStrategy <: AbstractLineLoaderStrategy

type NodeFileStrategy <: AbstractNodeFileStrategy
  points::Vector{Point}
  as::AbstractFileAttributesStrategy
  ms::AbstractFileMarkersStrategy
  sw::Switches
end

function NodeFileStrategy(size::Cint, as::AbstractFileAttributesStrategy,
                          ms::AbstractFileMarkersStrategy,
                          sw::Switches)
  NodeFileStrategy(Vector{Point}(size), as, ms, sw)
end

function createheader(ls::AbstractNodeFileStrategy,
                      parts::Vector{SubString{String}})
  NodesHeader(parse(Cint, parts[1]),
              parse(Cint, parts[2]),
              parse(Cint, parts[3]),
              parse(Cint, parts[4]))
end

function load!(ls::NodeFileStrategy, parts::Vector{SubString{String}},
               index::Cint)
  setnumbering!(ls.sw, parse(Cint, parts[1]))
  ls.points[index] = Point(parse(Cdouble, parts[2]), parse(Cdouble, parts[3]))
  load!(ls.as, parts, index)
  load!(ls.ms, parts, index)
end

load(ls::NodeFileStrategy) = NodeFile(ls.points, load(ls.as), load(ls.ms))

immutable NoNodeFileStrategy <: AbstractNodeFileStrategy end

load!(ls::NoNodeFileStrategy, line::String, index::Cint) = return

load(ls::NoNodeFileStrategy) = NoNodeFile()

type NodeFileLoader <: AbstractFileLoader
  file::String
  s::AbstractNodeFileStrategy
  sw::Switches
end

function NodeFileLoader(file::String, sw::Switches)
  NodeFileLoader(file, NoNodeFileStrategy(), sw)
end

function load!(l::NodeFileLoader, s::IOStream)
  h::NodesHeader = loadheader(l.s, s)
  size::Cint = length(h)
  if size == 0
    l.s = NoNodeFileStrategy()
  else
    if hasattrs(h) && hasmarkers(h)
      l.s = NodeFileStrategy(size, FileAttributesStrategy(h.cnt * h.attrcnt,
                                                          h.attrcnt, 4),
                             FileMarkersStrategy(h.cnt, 4 + h.attrcnt), l.sw)
    elseif hasattrs(h)
      l.s = NodeFileStrategy(size, FileAttributesStrategy(h.cnt * h.attrcnt,
                                                          h.attrcnt, 4),
                             NoFileMarkersStrategy(), l.sw)
    elseif hasmarkers(h)
      l.s = NodeFileStrategy(size, NoFileAttributesStrategy(),
                                   FileMarkersStrategy(h.cnt, 4), l.sw)
    else
      l.s = NodeFileStrategy(size, NoFileAttributesStrategy(),
                                   NoFileMarkersStrategy(), l.sw)
    end
  end
  load!(l.s, s, size)
end

getextension(l::NodeFileLoader) = "node"