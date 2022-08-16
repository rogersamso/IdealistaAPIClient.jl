using Test
using IdealistaAPIClient
using Serialization
using Dates
using Suppressor

const dir = joinpath(dirname(pathof(IdealistaAPIClient)), "..", "test", "testfiles")

include("utils.jl")
include("types.jl")
include("functions.jl")
