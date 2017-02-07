using Documenter, CTriangle

makedocs(
  modules = [CTriangle],
  format = :html,
  sitename = "CTriangle",
  pages    = Any[
    "Introduction to CTriangle"   => "index.md",
    "Examples"          => "examples.md",
  ]

)

deploydocs(
    repo = "github.com/kuzmamar/CTriangle.jl.git",
    julia  = "0.5"
)
