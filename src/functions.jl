
valid_fields(T::Type) = fieldnames(T)

function valid_fields()
    x = pushfirst!(subtypes(PropertyFields), Search)
    Dict(T=>valid_fields(T) for T in x)
end

function struct_to_dict(s)
    Dict(String(key)=>getfield(s, key) for key ∈ fieldnames(typeof(s)) if getfield(s, key)!=nothing)
end


function generate_credentials(apikey::AbstractString, secret::AbstractString)
    return Base64.base64encode(join(map(HTTP.escapeuri, [apikey, secret]), ":"))
end


function valid_token(token_d::Dict)::Bool
    
    haskey(token_d, "access_token") || throw(UndefKeywordError(:access_token))
    haskey(token_d, "expires_in") || throw(UndefKeywordError(:expires_in))
    isa(token_d["expires_in"], DateTime) || error("expires_in must be a DateTime object")

    if Dates.now() < token_d["expires_in"]
        return true
    else
        @info "Expired token"
        return false
    end
end

function get_token()::Dict{String, Any}
    
    serialization_path = joinpath(tempdir(), "idealista_tk.bin")
    
    if isfile(serialization_path)
        token_dict = deserialize(serialization_path)
        valid_token(token_dict) &&  return token_dict
    end

    @info "Getting new access token"

    local token_dict
    
    try
        creds = generate_credentials(APIKEY, SECRET)
        response = HTTP.post("https://api.idealista.com/oauth/token",
                      ["Content-Type" => "application/x-www-form-urlencoded",
                       "Authorization" => "Basic $creds"],
                      "grant_type=client_credentials&scope=read",
                      require_ssl_verification = false) 
    
        token_dict = JSON.parse(String(response.body))
    
    catch e
        rethrow(e)
    end

    # to store the full JSON response with expiraion date in datetime format
    token_dict["expires_in"] =  Dates.now() + Dates.Second(token_dict["expires_in"])
    
    # serializing token_dict
    serialize(serialization_path, token_dict)

    return token_dict

end


"""
    search(base_search::Search, property::Union{<:PropertyFields, Nothing}=nothing; token::Union{Dict{String, Any}, Nothing}=nothing)

Perform a search in the Idealista Search API

This method uses Search and property types instances as arguments

# Arguments
* `base_search`: Search object
* `property`: Homes, Premises, Garages, Bedrooms or Offices object

# Keyword Argyments
* `token_d`: Dict containing the API response for a token request

# Examples
```julia
julia> search(Search(country="es", center="40.430,-3.702", propertyType="homes", distance=15000, operation="sale"), Homes(bedrooms="1,2,3,4", swimmingPool=true))
[ Info: Getting new access token
Dict{String, Any} with 12 entries:
  "hiddenResults"      => false
  "itemsPerPage"       => 20
  "upperRangePosition" => 20
  "totalPages"         => 206
  "paginable"          => true
  "summary"            => Any["Comprar", "Viviendas", "barrio Trafalgar, Madrid", "Todos los…
  "total"              => 4118
  "lowerRangePosition" => 0
  "alertName"          => "Viviendas en barrio Trafalgar, Madrid"
  "elementList"        => Any[Dict{String, Any}("rooms"=>6, "propertyCode"=>"98324891", "num…
  "numPaginations"     => 0
  "actualPage"         => 1

```
"""
function search(base_search::Search, property::Union{<:PropertyFields, Nothing}=nothing; token_d::Union{Dict{String, Any}, Nothing}=nothing)::Dict{String, Any}
    
    if token_d != nothing
        valid_token(token_d) ? token = token_d["access_token"] : token = get_token()["access_token"]
    else
        token = get_token()["access_token"]
    end

    search_fields = validate_search_fields(base_search, property)
    request_data(token, search_fields)
end



"""
    search(base_search::Search, property::Union{<:PropertyFields, Nothing}=nothing; token::Union{Dict{String, Any}, Nothing}=nothing)

Perform a search in the Idealista Search API

This method uses keyword arguments corresponding to valid search fields of the Idealista Search API

# Keyword Argyments
* `token_d`: Dict containing the API response for a token request
* `kwargs`: search fields of the Idealista Search API 

# Examples
```julia
julia> search(country="es", center="40.430,-3.702", propertyType="homes", distance=15000, operation="sale", bedrooms="1,2,3,4", swimmingPool=true)
[ Info: Getting new access token
Dict{String, Any} with 12 entries:
  "hiddenResults"      => false
  "itemsPerPage"       => 20
  "upperRangePosition" => 20
  "totalPages"         => 206
  "paginable"          => true
  "summary"            => Any["Comprar", "Viviendas", "barrio Trafalgar, Madrid", "Todos los…
  "total"              => 4118
  "lowerRangePosition" => 0
  "alertName"          => "Viviendas en barrio Trafalgar, Madrid"
  "elementList"        => Any[Dict{String, Any}("rooms"=>6, "propertyCode"=>"98324891", "num…
  "numPaginations"     => 0
  "actualPage"         => 1

```
"""
function search(;token_d::Union{Dict{String, Any}, Nothing}=nothing, kwargs...)
    
    if token_d != nothing
        valid_token(token_d) ? token = token_d["access_token"] : token = get_token()["access_token"]
    else
        token = get_token()["access_token"]
    end

    search_fields = validate_search_fields(;(;kwargs...)...) 
    
    request_data(token, search_fields)

end


function validate_search_fields(base_search::Search, property::Union{<:PropertyFields, Nothing})::Dict

    property!=nothing && !isa(property, getfield(Main.IdealistaAPIClient, Symbol(uppercasefirst(base_search.propertyType)))) && error("The propertyType value in the Search struct must coincide with the type of the property argument") 
    
    search_fields = struct_to_dict(base_search)
    
    if property!=nothing
        merge!(search_fields, struct_to_dict(property))
    end

    return search_fields
end


function validate_search_fields(;kwargs...)::Dict

    search_fields = Dict(key=>getindex(kwargs, key) for key in keys(kwargs))
    
    base_search = Dict{Symbol, Any}()
    property_search = Dict{Symbol, Any}()

    for field ∈ keys(search_fields)
        if field ∈ fieldnames(Search)
            base_search[field] = search_fields[field]
        else
            property_search[field] = search_fields[field]
        end
    end

    search_obj = struct_to_dict(Search(;(;base_search...)...))

    if !isempty(property_search)
        
        property_type = getfield(Main.IdealistaAPIClient, Symbol(uppercasefirst(base_search[:propertyType])))

        property_search_fields = keys(property_search)
        
        for field in property_search_fields
            if field ∉ fieldnames(property_type)
                @info("$(String(field)) is not a valid field for $(base_search[:propertyType]), it will be ignored")
                pop!(property_search, field)
            end
        end
        
        property_obj = property_type(;(;property_search...)...) |> struct_to_dict
        merge!(search_obj, property_obj)

    end

    return search_obj
end


function request_data(token::AbstractString, search_fields::Dict{String, Any})
    
    try
        response = HTTP.post("https://api.idealista.com/3.5/$(getindex(search_fields, "country"))/search",
                             [ "Authorization" => "Bearer $token"],
                             body= search_fields)
        JSON.parse(String(response.body))
    
    catch e
        if isa(e, HTTP.Exceptions.StatusError)
            throw(ArgumentError(JSON.parse(String(e.response.body))["message"]))
        else
            rethrow(e)
        end
    end
end
