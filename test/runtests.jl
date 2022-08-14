using Test
using IdealistaAPIClient
using Serialization
using Dates
using Suppressor

const dir = joinpath(dirname(pathof(IdealistaAPIClient)), "..", "test", "testfiles")

include("types.jl")
include("functions.jl")
