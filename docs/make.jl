using Documenter, IdealistaAPIClient

DocMeta.setdocmeta!(IdealistaAPIClient, :DocTestSetup, :(using IdealistaAPIClient); recursive=true)

makedocs(sitename="IdealistaAPIClient.jl",
         modules = [IdealistaAPIClient],
        pages = [
        "Introduction" => "index.md",
        "Usage" => "usage.md",
        "API" => Any["Types" => "types.md",
                     "Functions" => "functions.md"]
    ])
