abstract Input

type DelaunayFileInput <: Input
  options::String
  nf::NodeFile
end

type ConstrainedDelaunayFileInput <: Input
  options::String
  pf::PolyFile
end

type DelaunayRefinementFileInput <: Input
  options::String
  nf::NodeFile
  ef::EleFile
  af::AreaFile
end

type ConstrainedDelaunayRefinementFileInput <: Input
  options::String
  pf::PolyFile
  ef::EleFile
  af::AreaFile
end
