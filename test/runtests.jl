using Test
using IdealistaAPIClient

const dir = joinpath(dirname(pathof(IdealistaAPIClient)), "..", "test", "testfiles")

include("types.jl")
include("functions.jl")
