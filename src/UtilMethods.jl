const COMMENT = '#'

remove_extension(file_name::String) = splitext(file_name)[1]

read_line(s::IOStream) = strip(readline(s))

read_clear_line(s::IOStream) = read_clear_line(read_line(s), s)

function read_clear_line(line::String, s::IOStream)
	tmp = line
	while searchindex(tmp, COMMENT, 1) == 1
		tmp = read_line(s)
	end
	tmp
end

read_file_line(is::IOStream) = split(read_clear_line(is))

function get_index(start_index::Cint, index::Cint)
	start_index > Cint(0) ? index : Cint(index + 1)
end

function parse_points(
  points::Vector{Cdouble}, line::Vector{SubString{String}}, index::Cint,
  start::Cint
)
  second = 2 * index
  points[second - 1] = parse(Cdouble, line[start])
  points[second] = parse(Cdouble, line[start + 1])
end

function parse_attrs(
  attrs::Vector{Cdouble}, line::Vector{SubString{String}}, index::Cint,
  start::Cint, attr_cnt::Cint
)
  last = attr_cnt * index
  first = last - attr_cnt + 1
  current = start
  for i in first:last
    attrs[i] = parse(Cdouble, line[current])
    current = current + 1
  end
end

function parse_markers(
  markers::Vector{Cint}, line::Vector{SubString{String}}, index::Cint,
  start::Cint
)
  markers[index] = parse(Cint, line[start])
end

function parse_segments(
	segments::Vector{Cint}, line::Vector{SubString{String}}, index::Cint,
	start::Cint, start_index::Cint
)
	second = 2 * index
	segments[second - 1] = get_index(start_index, parse(Cint, line[start]))
	segments[second] = get_index(start_index, parse(Cint, line[start + 1]))
end

function parse_holes(
	holes::Vector{Cdouble}, line::Vector{SubString{String}}, index::Cint,
	start::Cint
)
	second = 2 * index
	holes[second - 1] = parse(Cdouble, line[start])
	holes[second] = parse(Cdouble, line[start + 1])
end

function parse_regions(
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
		regions[first + 3] = parse(Cdouble, line[start + 2])
	end
end

function parse_elems(
	elems::Vector{Cint}, line::Vector{SubString{String}}, index::Cint,
	start::Cint, corner_cnt::Cint, start_index::Cint
)
	last = index * corner_cnt
	first = last - corner_cnt + 1
	current = start
	for i in first:last
		elems[i] = get_index(start_index, parse(Cint, line[current]))
		current = current + 1
	end
end

function parse_areas(
	areas::Vector{Cdouble}, line::Vector{SubString{String}}, index::Cint,
	start::Cint
)
	areas[index] = parse(Cdouble, line[start])
end

function create_markers(read_markers::Bool, marker::Cint)
	if read_markers == true && marker > Cint(0)
		Vector{Cint}(cnt)
	else
		Vector{Cint}[]
	end
end
