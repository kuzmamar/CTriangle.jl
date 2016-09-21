abstract File

type NodeFile <: File
  s::NodeSection
end

type NoNodeFile <: NodeFile end

type PolyFile <: File
  nf::NodeFile
  ss::SegmentSection
  hs::HoleSection
  rs::RegionSection
end
