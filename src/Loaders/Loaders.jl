removeext(file::ASCIIString) = splitext(file)[1]

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
  firstattr::Int
end

function FileAttributesStrategy(size::Cint, attrcnt::Cint, firstattr::Int)
  FileAttributesStrategy(Vector{Cdouble}(size), attrcnt, firstattr)
end

function load!(ls::FileAttributesStrategy,
               parts::Vector{SubString{ASCIIString}},
               index::Cint)
  firstattr::Cint = ls.firstattr 
  lastattr::Cint = firstattr + ls.attrcnt - 1
  attrindex::Cint = ls.attrcnt == 1 ? index : index + index - 1
  @inbounds for i::Cint in firstattr:lastattr
    ls.attrs[attrindex] = parse(Cdouble, parts[i])
    attrindex = attrindex + 1
  end
end

load(ls::FileAttributesStrategy) = FileAttributes(ls.attrs, ls.attrcnt)

immutable NoFileAttributesStrategy <: AbstractFileAttributesStrategy end

load(ls::NoFileAttributesStrategy) = NoFileAttributes()

abstract AbstractFileMarkersStrategy <: AbstractLineParserStrategy

type FileMarkersStrategy <: AbstractFileMarkersStrategy
  markers::Vector{Cint}
  firstmarker::Int
end

function FileMarkersStrategy(size::Cint, firstmarker::Int)
  FileMarkersStrategy(Vector{Cint}(size), firstmarker)
end

function load!(ls::FileMarkersStrategy,
               parts::Vector{SubString{ASCIIString}},
               index::Cint)
  ls.markers[index] = parse(Cint, parts[ls.firstmarker])
end

load(ls::FileMarkersStrategy) = FileMarkers(ls.markers)

immutable NoFileMarkersStrategy <: AbstractFileMarkersStrategy end

load(ls::NoFileMarkersStrategy) = NoFileMarkers()

include("NodeFileLoader.jl")
