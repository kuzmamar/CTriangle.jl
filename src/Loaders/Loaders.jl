removeext(file::ASCIIString) = splitext(path)[1]

readclearline(s::IOStream) = readclearline(readline(s), s)

function readclearline(line::ASCIIString, stream::IOStream)
	tmp::ASCIIString = line
	while searchindex(tmp, "#", 1) == 1
		tmp = readline(stream)
	end
	tmp
end

abstract AbstractFileLoader

function load!(l::AbstractFileLoader)
  s::IOStream = open("$(l.file).$(getextension(l))")
  f::AbstractFile = load!(l, s)
  close(s)
  f
end

abstract AbstractObjectLoader

abstract AbstractLineLoaderStrategy

function load!(ls::AbstractLineLoaderStrategy, s::IOStream, size::Cint)
  for index::Cint in 1:size
    load!(ls, readclearline(s), index)
  end
  load(ls)
end

function loadheader(ls::AbstractLineLoaderStrategy, s::IOStream)
  createheader(ls, split(readclearline(s)))
end

function load!(ls::AbstractLineLoaderStrategy, line::ASCIIString, index::Cint)
  load!(ls, split(line), index)
end

abstract AbstractLineParserStrategy

function load!(ls::AbstractLineParserStrategy,
               parts::Vector{SubString{ASCIIString}},
               index::Cint)
end

abstract AbstractFileAttributesStrategy <: AbstractLineParserStrategy

type FileAttributesStrategy <: AbstractFileAttributesStrategy
  attrs::Vector{Cdouble}
  attrcnt::Cint
  offset::Int
end

function FileAttributesStrategy(size::Cint, attrcnt, offset::Int)
  FileAttributesStrategy(Vector{Cdouble}(size), attrcnt, offset)
end

function load!(ls::FileAttributesStrategy,
               parts::Vector{SubString{ASCIIString}},
               index::Cint)
  last::Cint =  index * ls.attrcnt + ls.offset
  first::Cint = last - ls.attrcnt + 1
  for current::Cint in first:last
    ls.attrs[current - ls.offset] = parse(Cdouble, parts[current])
  end
end

load(ls::FileAttributesStrategy) = FileAttributes(ls.attrs. ls.attrcnt)

immutable NoFileAttributesStrategy <: AbstractFileAttributesStrategy end

load(ls::NoFileAttributesStrategy) = NoFileAttributes()

abstract AbstractFileMarkersStrategy <: AbstractLineParserStrategy

type FileMarkersStrategy <: AbstractFileMarkersStrategy
  markers::Vector{Cint}
  offset::Int
end

function FileMarkersStrategy(size::Cint, offset::Int)
  FileMarkersStrategy(Vector{Cint}(size), offset)
end

function load!(ls::FileMarkersStrategy,
               parts::Vector{SubString{ASCIIString}},
               index::Cint)
  ls.markers[index] = parse(Cint, parts[index + ls.offset])
end

load(ls::FileMarkersStrategy) = FileMarkers(ls.markers)

immutable NoFileMarkersStrategy <: AbstractFileMarkersStrategy end

load(ls::NoFileMarkersStrategy) = NoFileMarkers()

include("NodeFileLoaders.jl")
