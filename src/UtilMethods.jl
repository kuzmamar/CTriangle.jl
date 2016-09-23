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
	println(index)
  markers[index] = parse(Cint, line[start])
end
