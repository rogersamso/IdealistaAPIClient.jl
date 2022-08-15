# Installation instructions

At the Julia REPL:

```julia
using Pkg 

Pkg.add(url="https://github.com/rogersamso/IdealistaAPIClient.jl")

```


# Usage

There are two interfaces to perform searches, one using keyword arguments, and another one using the Search and PropertyFields subtypes.

Here is an example of the keywords inteface:

```julia
using IdealistaAPIClient

# see list of valid fields for each property type
# note that only some of the Search type fields must be passed, while the rest are optional (see the Valid search fields section below)
valid_fields()

# define search fields
search_fields = (country="es", center="40.430,-3.702", propertyType="homes", distance=15000, operation="sale", bedrooms="1,2,3,4", swimmingPool=true)

response_body = search(;search_fields...)

```

Here is the alternative way to search for a property:

```julia
using IdealistaAPIClient

# Instantiate the Search and Homes structs
search_fields = Search(country="es", center="40.430,-3.702", propertyType="homes", distance=15000, operation="sale")

home_fields = Homes(bedrooms="1,2,3,4", swimmingPool=true)

response_body = search(search_fields, home_fields)

```

The response body, as expected, is the body of the response of our request, in the form of a dictionary. The response can be then turned into a `Response` object by passing it to the `process_response` function.
