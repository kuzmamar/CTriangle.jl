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

function createNodeFileSection(
	points::Vector{Cdouble}, pointCnt::Cint, attrs::Vector{Cdouble}, attrCnt::Cint,
	markers::Vector{Cint}
)
end

function createPoint(points::Vector{Cdouble}, index::Int)
	secondIndex::Int = index * 2
	firstIndex::Int = secondIndex - 1
	size::Int = length(points)
	if (firstIndex > 0 && secondIndex > 0) &&
		 (firstIndex <= size && secondIndex <= size)
		 Point(index, points[firstIndex], points[secondIndex])
	else
		error("No point found on index \"$index\"")
	end
end

function createAttrs(attrs::Vector{Cdouble}, attrCnt::Cint, index::Int)
	size::Int = attrCnt == 0 ? 0 : length(attrs) / attrCnt
	if size == 0
		return ()
	end
	if index > 0 && index <= size
		lastAttr::Int = index * attrCnt
		firstAttr::Int = lastAttr - attrCnt + 1
		tmpAttrs::Vector{Cdouble} = Vector{Cdouble}(attrCnt)
		current::Int = 1
		for i::Int in firstAttr:lastAttr
			tmpAttrs[current] = attrs[i]
			current = current + 1
		end
		tuple(tmpAttrs...)
	else
		error("No attributes found on index \"$index\"")
	end
end

function getMarker(markers::Vector{Cint}, index::Int)
	size::Int = length(markers)
	if size == 0
		return Cint(0)
	end
	if index > 0 && index <= size
		markers[index]
	else
		error("No marker found on index \"$index\"")
	end
end

function createNode(
	points::Vector{Cdouble},
	attrs::Vector{Cdouble}, attrCnt::Cint,
	markers::Vector{Cint},
	index::Int
)
	Node(
		createPoint(points, index),
		createAttrs(attrs, iterator.attrCnt, index),
		getMarker(markers, index)
	)
end

function filterNeighbors(neighbors::Vector{Cint}, index::Int)
	last::Int = index * 3
	first::Int = last - 2
	filtered::Vector{Int} = Int[]
	for i::Int in first:last
		if neighbors[i] !== Cint(-1)
			push!(filtered, Int(neighbors[i]))
		end
	end
	filtered
end
