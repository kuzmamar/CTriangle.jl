using Documenter, CTriangle

makedocs(
  modules=[CTriagle]
)

deploydocs(
  deps   = Deps.pip("mkdocs", "python-markdown-math"),
  repo   = "github.com/kuzmamar/CTriangle.jl.git",
  julia  = "0.5",
  osname = "linux"
)
