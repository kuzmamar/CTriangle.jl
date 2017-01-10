using Documenter, CTriangle

makedocs(
  modules = [CTriangle],
  format = :html,
  sitename = "CTriangle",
  pages    = Any[
    "Introduction to CTriangle"   => "index.md",
    "Examples"          => "examples.md",
  #  "Basic graphics"          => "basics.md",
  #  "Styling"                 => "styling.md",
  #  "Polygons"                => "polygons.md",
  #  "Text"                    => "text.md",
  #  "Transforms and matrices" => "transforms.md",
  #  "Clipping"                => "clipping.md",
  #  "Images"                  => "images.md",
  #  "Turtle graphics"         => "turtle.md",
  #  "Animation"               => "animation.md",
  #  "More examples"           => "moreexamples.md",
  #  "Index"                   => "functionindex.md"
  ]

)

deploydocs(
    repo = "github.com/kuzmamar/CTriangle.jl.git",
    target = "build",
    julia  = "0.5",
    osname = "linux",
    deps = nothing,
    make = nothing,
)
