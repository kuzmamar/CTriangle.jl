abstract FileSectionStreamInterface

type NodeFileSectionStream <: FileSectionStreamInterface
  fileStream::IO
end

type SegmentFileSectionStream <: FileSectionStreamInterface
  fileStream::IO
  startIndex::Cint
end

type HoleFileSectionStream <: FileSectionStreamInterface
  fileStream::IO
  useHoles::Bool
end

type RegionFileSectionStream <: FileSectionStreamInterface
  fileStream::IO
  useRegions::Bool
end

type ElementFileSectionStream <: FileSectionStreamInterface
  fileStream::IO
  startIndex::Cint
end

type AreaFileSectionStream <: FileSectionStreamInterface
  fileStream::IO
end
