abstract File

type NodeFile <: File
  s::NodeSection
end

type PolyFile <: File
  ns::NodeSection
  ss::SegmentSection
  hs::HoleSection
  rs::RegionSection
end
