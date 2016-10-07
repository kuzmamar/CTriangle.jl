abstract InputInterface

abstract DelaunayInputInterface <: InputInterface

type DelaunayFileInput <: DelaunayInputInterface
  options::String
  nodeFile::NodeFile
end

type DelaunayInput <: DelaunayInputInterface
  # todo for user input
end

type ConstrainedDelaunayFileInput <: InputInterface
  options::String
  polyFile::PolyFile
end

type DelaunayRefinementFileInput <: InputInterface
  options::String
  nodeFile::NodeFile
  eleFile::EleFile
  areaFile::AreaFile
end

type ConstrainedDelaunayRefinementFileInput <: InputInterface
  options::String
  polyFile::PolyFile
  eleFile::EleFile
  areaFile::AreaFile
end
