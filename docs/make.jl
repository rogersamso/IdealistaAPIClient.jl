using Documenter, IdealistaAPIClient

makedocs(sitename="IdealistaAPIClient.jl",
        pages = [
        "Introduction" => "intro.md",
        "Usage" => "usage.md",
        "API" => Any["Types" => "types.md",
                     "Functions" => "functions.md"]
    ])
