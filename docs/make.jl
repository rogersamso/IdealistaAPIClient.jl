using Documenter, IdealistaAPIClient

# DocMeta.setdocmeta!(IdealistaAPIClient, :DocTestSetup, :(using IdealistaAPIClient); recursive=true)

makedocs(sitename="IdealistaAPIClient.jl",
        # doctest = false, # TODO activate them at some point
        pages = [
        "Introduction" => "intro.md",
        "Usage" => "usage.md",
        "API" => Any["Types" => "types.md",
                     "Functions" => "functions.md"]
    ])
