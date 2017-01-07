function getNode(section::NodeTriangulationSection, index::Int)
  try
    Node(
  		createPoint(section.points, index),
  		createAttrs(section.attrs, section.attrCnt, index),
  		getMarker(section.markers, index)
  	)
  catch
    error("No node found on index \"$index\".")
  end
end

function getSegment(
  nodeSection::NodeTriangulationSection,
  segmentSection::SegmentTriangulationSection,
  index::Int
)
  if index > 0 && index <= length(segmentSection)
    second::Int = index * 2
    try
      Segment(
        index,
        createPoint(nodeSection.points, Int(segmentSection.segments[second - 1])),
        createPoint(nodeSection.points, Int(segmentSection.segments[second])),
        getMarker(segmentSection.markers, index)
      )
    catch
      error("No segment found on index \"$index\".")
    end
  else
    error("No segment found on index \"$index\".")
  end
end

function getSegment(
  nodeSection::NodeTriangulationSection,
  segmentSection::NoSegmentTriangulationSection,
  index::Int
)
  error("No segment found on index \"$index\".")
end

function getHole(section::HoleTriangulationSection, index::Int)
  if index > 0 && index <= length(section)
    try
      createPoint(section.holes, Int(segmentSection.segments[index]))
    catch
      error("No hole found on index \"$index\".")
    end
  else
    error("No hole found on index \"$index\".")
  end
end

function getHole(section::NoHoleTriangulationSection, index::Int)
  error("No hole found on index \"$index\".")
end

function getRegion(
  regionSection::RegionTriangulationSection,
  index::Int
)
  areaIndex::Int = index * 4
  firstIndex::Int = areaIndex - 3
  size::Int = length(regions)
  if (firstIndex > 0 && areaIndex > 0) &&
     (firstIndex <= size && areaIndex <= size)
     Region(
       Point(index, regions[firstIndex], regions[firstIndex + 1]),
       regions[areaIndex - 1],
       regions[areaIndex]
    )
  else
    error("No region found on index \"$index\"")
  end
end

function getRegion(
  regionSection::NoRegionTriangulationSection,
  index::Int
)
  error("No region found on index \"$index\"")
end

function getElement(
  nodeSection::NodeTriangulationSection,
  elementSection::ElementTriangulationSection,
  index::Int
)
  if index > 0 && index <= length(elementSection)
    Element(
      index,
      createPoints(nodeSection, elementSection, index),
      createAttrs(elementSection, index),
      createNeighbors(nodeSection, elementSection, index)
    )
  else
    error("No element found on index \"$index\".")
  end
end

function getElement(
  nodeSection::NodeTriangulationSection,
  elementSection::NoElementTriangulationSection,
  index::Int
)
  error("No element found on index \"$index\".")
end

function createPoints(
  nodeSection::NodeTriangulationSection,
  elementSection::ElementTriangulationSection,
  index::Int
)
  last::Int = index * elementSection.cornerCnt
  first::Int = last - elementSection.cornerCnt + 1
  points::Vector{Point} = Vector{Point}(elementSection.cornerCnt)
  current::Int = 1
  for i::Int in first:last
    points[current] = createPoint(nodeSection.points, Int(elementSection.elems[i]))
    current = current + 1
  end
  tuple(points...)
end

function createPoints(
  nodeSection::NodeTriangulationSection,
  elementSection::NoElementTriangulationSection,
  index::Int
)
  error("No element found on index \"$index\".")
end

function createAttrs(section::ElementTriangulationSection, index::Int)
  createAttrs(section.attrs, section.attrCnt, index)
end

function createAttrs(section::NoElementTriangulationSection, index::Int)
  error("No element found on index \"$index\".")
end

function createNeighbors(
  nodeSection::NodeTriangulationSection,
  elementSection::ElementTriangulationSection,
  index::Int
)
  filterNeighbors(elementSection.neighbors, index)
end

function createNeighbors(
  nodeSection::NodeTriangulationSection,
  elementSection::NoElementTriangulationSection,
  index::Int
)
  error("No element found on index \"$index\".")
end

function getEdge(
  nodeSection::NodeTriangulationSection,
  edgeSection::EdgeTriangulationSection,
  index::Int
)
  if index > 0 && index <= length(edgeSection)
    second::Int = index * 2
    Edge(
      index,
      createPoint(nodeSection.points, Int(edgeSection.edges[second - 1])),
      createPoint(nodeSection.points, Int(edgeSection.edges[second])),
      getMarker(edgeSection.markers, index)
    )
  else
    error("No edge found on index \"$index\".")
  end
end

function getEdge(
  nodeSection::NodeTriangulationSection,
  edgeSection::NoEdgeTriangulationSection,
  index::Int
)
  error("No edge found on index \"$index\".")
end

function Base.length(section::NodeTriangulationSection)
  length(section.points) / 2
end

Base.length(section::ElementTriangulationSectionInterface) = 0

function Base.length(section::ElementTriangulationSection)
  length(section.elems) / section.cornerCnt
end

Base.length(section::SegmentTriangulationSectionInterface) = 0

function Base.length(section::SegmentTriangulationSection)
  length(section.segments) / 2
end

Base.length(section::EdgeTriangulationSectionInterface) = 0

function Base.length(section::EdgeTriangulationSection)
  length(section.edges) / 2
end

Base.length(section::HoleTriangulationSectionInterface) = 0

function Base.length(section::HoleTriangulationSection)
  length(section.holes) / 2
end

Base.length(section::RegionTriangulationSectionInterface) = 0

function Base.length(section::RegionTriangulationSection)
  length(section.regions) / 4
end
