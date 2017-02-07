using Documenter, CTriangle

makedocs(
  modules=[CTriangle]
)

deploydocs(
  deps   = Deps.pip("mkdocs", "python-markdown-math"),
  repo   = "github.com/kuzmamar/CTriangle.jl.git",
  julia  = "0.5",
  osname = "linux"
)
