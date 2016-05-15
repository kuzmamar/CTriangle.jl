using CTriangle, Lexicon, Docile

const api_directory = "api"
const modules = Docile.Collector.submodules(CTriangle)

# Generate and save the contents of docstrings as markdown files.
index  = Index()
config = Config(md_subheader = :category, category_order = [:module,    :function, :method, :type,
                                                            :typealias, :macro,    :global])
for mod in modules
    update!(index, save(joinpath(api_directory, "$(mod).md"), mod, config))
end
save(joinpath(api_directory, "index.md"), index, config)
