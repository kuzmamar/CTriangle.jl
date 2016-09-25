Base.close(fs::FileStream) = close(get_stream(fs))

read(::FileStream) = error("Implement method read")

function read(fs::NodeFileStream)
  nss = NodeSectionStream(fs.fs, fs.read_markers)
  NodeFile(read(nss))
end

function read(fs::PolyFileStream)
  nss = NodeSectionStream(fs.fs, fs.read_markers)
  ns = read(nss)
  if is_empty(ns)
    n = NodeFileName(fs.file_name, fs.read_markers)
    nf = read(n)
    ns = nf.ns
  end
  start_index = get_start_index(ns)
  sss = SegmentSectionStream(fs.fs, fs.read_markers, start_index)
  ss = read(sss)
  hss = HoleSectionStream(fs.fs, fs.read_holes)
  hs = read(hss)
  rss = RegionSectionStream(fs.fs, fs.read_regions)
  rs = read(rss)
  PolyFile(ns, ss, hs, rs)
end

function read(fs::EleFileStream)
  ess = ElementSectionStream(fs.fs, fs.start_index)
  EleFile(read(ess))
end

function read(fs::AreaFileStream)
  ass = AreaSectionStream(fs.fs)
  AreaFile(read(ass))
end

get_stream(fs::FileStream) = fs.fs
