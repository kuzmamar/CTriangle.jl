abstract SectionStreamInterface

type NodeSectionStream <: SectionStreamInterface
  fileStream::IO
end

type SegmentSectionStream <: SectionStreamInterface
  fileStream::IO
  startIndex::Cint
end

type HoleSectionStream <: SectionStreamInterface
  fileStream::IO
  useHoles::Bool
end

type RegionSectionStream <: SectionStreamInterface
  fileStream::IO
  useRegions::Bool
end

type ElementSectionStream <: SectionStreamInterface
  fileStream::IO
  startIndex::Cint
end

type AreaSectionStream <: SectionStreamInterface
  fileStream::IO
end
