using Documenter, IdealistaAPIClient

DocMeta.setdocmeta!(IdealistaAPIClient, :DocTestSetup, :(using IdealistaAPIClient); recursive=true)

makedocs(sitename="IdealistaAPIClient.jl",
         modules = [IdealistaAPIClient],
         authors="Roger Samsó <r.samso@proton.me>",
         format=Documenter.HTML(
                                prettyurls=get(ENV, "CI", nothing) == "true",
                                canonical="https://rogersamso.github.io/IdealistaAPIClient.jl/stable/",
                                assets=String[],
                               ),
         pages = [
            "Introduction" => "index.md",
            "Usage" => "usage.md",
             "API" => Any["Types" => "types.md",
                          "Functions" => "functions.md"]
            ],
        )

deploydocs(
           repo="github.com/rogersamso/IdealistaAPIClient.jl.git",
           devbranch="main",
          )
