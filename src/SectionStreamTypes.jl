abstract SectionStream

type NodeSectionStream <: SectionStream
  fs::IOStream
  read_markers::Bool
end

type SegmentSectionStream <: SectionStream
  fs::IOStream
  read_markers::Bool
  start_index::Cint
end

type HoleSectionStream <: SectionStream
  fs::IOStream
  read_holes::Bool
end

type RegionSectionStream <: SectionStream
  fs::IOStream
  read_regions::Bool
end

type ElementSectionStream <: SectionStream
  fs::IOStream
  start_index::Cint
end

type AreaSectionStream <: SectionStream
  fs::IOStream
end
