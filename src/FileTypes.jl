abstract File

type NodeFile <: File
  ns::NodeSection
end

type PolyFile <: File
  ns::NodeSection
  ss::SegmentSection
  hs::HoleSection
  rs::RegionSection
end

type EleFile <: File
  es::ElementSection
end

type AreaFile <: File
  as::AreaSection
end
