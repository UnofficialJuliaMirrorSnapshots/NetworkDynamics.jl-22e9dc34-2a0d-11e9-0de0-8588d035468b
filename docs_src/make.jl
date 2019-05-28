using Revise
using Documenter
push!(LOAD_PATH, "../")
using NetworkDynamics

makedocs(
    sitename = "NetworkDynamics",
    format = Documenter.HTML(canonical = "https://FHell.github.io/NetworkDynamics.jl/"),
    linkcheck=true,
    modules = [NetworkDynamics],
    pages = [
    "General" => "index.md",
    "Functions_and_Constructors.md",
    "StaticEdges.md",
    "DynamicEdges.md",
    ]) #Here we have to agree on the Page structure yet.

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
#=deploydocs(
    repo = "<repository url>"
)=#

cp("docs_src/build", "docs", force=true)
