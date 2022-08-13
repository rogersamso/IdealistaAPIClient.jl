module IdealistaAPIClient

using HTTP
using JSON
using Base64
using Dates
using Serialization
using InteractiveUtils


export
    get_token,
    search,
    valid_fields,
    Search,
    Garages,
    Premises,
    Homes,
    Offices,
    Bedrooms

include("types.jl")
include("functions.jl")


end
