const COMMENT = '#'

removeExtension(fileName::String) = splitext(fileName)[1]

readLine(s::IO) = strip(readline(s))

readClearLine(s::IO) = readClearLine(readLine(s), s)

function readClearLine(line::String, s::IO)
	tmp = line
	while searchindex(tmp, COMMENT, 1) == 1
		tmp = readLine(s)
	end
	tmp
end

readFileLine(is::IO) = split(readClearLine(is))

function getIndex(startIndex::Cint, index::Cint)
	startIndex > Cint(0) ? index : Cint(index + 1)
end

function parsePoints(
  points::Vector{Cdouble}, line::Vector{SubString{String}}, index::Cint,
  start::Cint
)
  second = 2 * index
  points[second - 1] = parse(Cdouble, line[start])
  points[second] = parse(Cdouble, line[start + 1])
end

function parseAttrs(
  attrs::Vector{Cdouble}, line::Vector{SubString{String}}, index::Cint,
  start::Cint, attrCnt::Cint
)
  last = attrCnt * index
  first = last - attrCnt + 1
  current = start
  for i in first:last
    attrs[i] = parse(Cdouble, line[current])
    current = current + 1
  end
end

function parseMarkers(
  markers::Vector{Cint}, line::Vector{SubString{String}}, index::Cint,
  start::Cint
)
  markers[index] = parse(Cint, line[start])
end

function parseSegments(
	segments::Vector{Cint}, line::Vector{SubString{String}}, index::Cint,
	start::Cint, startIndex::Cint
)
	second = 2 * index
	segments[second - 1] = getIndex(startIndex, parse(Cint, line[start]))
	segments[second] = getIndex(startIndex, parse(Cint, line[start + 1]))
end

function parseHoles(
	holes::Vector{Cdouble}, line::Vector{SubString{String}}, index::Cint,
	start::Cint
)
	second = 2 * index
	holes[second - 1] = parse(Cdouble, line[start])
	holes[second] = parse(Cdouble, line[start + 1])
end

function parseRegions(
	regions::Vector{Cdouble}, line::Vector{SubString{String}}, index::Cint,
	start::Cint
)
	first = 4 * index - 3

	regions[first] = parse(Cdouble, line[start])
	regions[first + 1] = parse(Cdouble, line[start + 1])
	if length(line) >= 5
		regions[first + 2] = parse(Cdouble, line[start + 2])
		regions[first + 3] = parse(Cdouble, line[start + 3])
	else
		regions[first + 2] = Cdouble(0)
		regions[first + 3] = parse(Cdouble, line[start + 2])
	end
end

function parseElems(
	elems::Vector{Cint}, line::Vector{SubString{String}}, index::Cint,
	start::Cint, cornerCnt::Cint, startIndex::Cint
)
	last = index * cornerCnt
	first = last - cornerCnt + 1
	current = start
	for i in first:last
		elems[i] = getIndex(startIndex, parse(Cint, line[current]))
		current = current + 1
	end
end

function parseAreas(
	areas::Vector{Cdouble}, line::Vector{SubString{String}}, index::Cint,
	start::Cint
)
	areas[index] = parse(Cdouble, line[start])
end

function createMarkers(marker::Cint, markerCnt::Cint)
	if marker > Cint(0)
		Vector{Cint}(markerCnt)
	else
		Vector{Cint}[]
	end
end

function createFakeIO(lines::Vector{String})
	FakeIO(lines)
end

function createNodeHandler(fileName::NodeNameInterface)
	NodeHandler(fileName)
end

function createPolyHandler(
	nodeName::NodeNameInterface, polyName::PolyNameInterface,
	useHoles::Bool, useRegions::Bool
)
	PolyHandler(
		polyName,
		createNodeHandler(nodeName),
		useHoles,
		useRegions
	)
end

function createEleHandler(fileName::EleNameInterface, startIndex::Cint)
	EleHandler(fileName, startIndex)
end

function createAreaHandler(fileName::AreaNameInterface, useAreas::Bool)
	AreaHandler(fileName, useAreas)
end
