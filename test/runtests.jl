using Test
using IdealistaAPIClient
using Serialization

const dir = joinpath(dirname(pathof(IdealistaAPIClient)), "..", "test", "testfiles")

include("types.jl")
include("functions.jl")
