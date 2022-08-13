import Base: @kwdef, show # these fields must be in the search fields


abstract type SearchFields end
abstract type PropertyFields <: SearchFields end

"""
    Search <: SearchFields

A struct that stores the basic (non-property-type specific) search fields
of the Idealista Search API

Each field represents a valid base search field for the Idealista Search API.
The country, operation, propertyType and center + distance or center + locationId
are mandatory

# Constructors
```julia

Search(country,
       operation,
       propertyType,
       center,
       distance,
       locationId,
       maxItems,
       numPage,
       maxPrice,
       minPrice,
       sinceDate,
       orderg,
       sort,
       adIds,
       hasMultimedia)

Search(; country::String,
         operation::String,
         propertyType::String,
         center::String,
         distance::Union{<:Int, Nothing}=nothing,
         locationId::Union{<:AbstractString, Nothing}=nothing,
         maxItems::Union{<:Int, Nothing}=nothing,
         numPage::Union{<:Int, Nothing}=nothing,
         maxPrice::Union{<:Number, Nothing}=nothing,
         minPrice::Union{<:Number, Nothing}=nothing,
         sinceDate::Union{<:AbstractString, Nothing}=nothing,
         order::Union{<:AbstractString, Nothing}=nothing,
         sort::Union{<:AbstractString, Nothing}=nothing,
         adIds::Union{<:Int, Nothing}=nothing,
         hasMultimedia::Union{Bool, Nothing}=nothing)
```

# Examples
```jldoctest
julia>Search("es", "sale", "homes", "42.0,-3.7", 15000, nothing, nothing, nothing, nothing, nothing, nothing, nothing, nothing, nothing, nothing)
Search:
	country => es
	operation => sale
	propertyType => homes
	center => 42.0,-3.7
	distance => 15000
	locationId => nothing
	maxItems => nothing
	numPage => nothing
	maxPrice => nothing
	minPrice => nothing
	sinceDate => nothing
	order => nothing
	sort => nothing
	adIds => nothing
	hasMultimedia => nothing

julia> Search(country="it", operation="sale", propertyType="homes", center="42.0,-3.7", distance=15000)
Search:
	country => it
	operation => sale
	propertyType => homes
	center => 42.0,-3.7
	distance => 15000
	locationId => nothing
	maxItems => nothing
	numPage => nothing
	maxPrice => nothing
	minPrice => nothing
	sinceDate => nothing
	order => nothing
	sort => nothing
	adIds => nothing
	hasMultimedia => nothing

```
"""
@kwdef struct Search <: SearchFields
    country::String
    operation::String
    propertyType::String
    center::String
    distance::Union{<:Int, Nothing}=nothing
    locationId::Union{<:AbstractString, Nothing}=nothing
    maxItems::Union{<:Int, Nothing}=nothing
    numPage::Union{<:Int, Nothing}=nothing
    maxPrice::Union{<:Number, Nothing}=nothing
    minPrice::Union{<:Number, Nothing}=nothing
    sinceDate::Union{<:AbstractString, Nothing}=nothing
    order::Union{<:AbstractString, Nothing}=nothing
    sort::Union{<:AbstractString, Nothing}=nothing
    adIds::Union{<:Int, Nothing}=nothing
    hasMultimedia::Union{Bool, Nothing}=nothing

    function Search(country, operation, propertyType, center, distance, locationId, maxItems, numPage, maxPrice, minPrice, sinceDate, order, sort, adIds, hasMultimedia)

        isnothing(distance) && isnothing(locationId) && error("Provide either distance of locationId")
        ~isnothing(distance) && ~isnothing(locationId) && error("Provide either distance of locationId, but not both")
        country ∉  ["es", "pt", "it"] && throw(DomainError(:country, "Country field can only be es, pt or it"))
        operation ∉ ["sale", "rent"] && throw(DomainError(:operation, "Only sell and rent operations are allowed"))
        propertyType ∉ ["homes", "offices", "premises", "garages", "bedrooms"] && throw(DomainError(:propertyType,"propertyType can only take homes, offices, premises, garages or bedrooms"))
        ~isnothing(sort) && ∉(sort, ["asc", "desc"]) && throw(DomainError(:sort, "the sort field can only be set to asc or desc"))
        ~isnothing(sinceDate) && ∉(sinceDate, ["W", "M", "T", "Y"]) && throw(DomainError(:sinceDate, "the sinceDate field only accepts W, M, T, Y"))

        # TODO should also limit the values of the sort field, depending on the given propertyType field.


        new(country, operation, propertyType, center, distance, locationId, maxItems, numPage, maxPrice, minPrice, sinceDate, order, sort, adIds, hasMultimedia)
    end
end


"""
    Garages <: PropertyFields

A struct that stores the garage specific search fields

Each field represents a valid garages search field for the Idealista Search API

# Constructors
```julia

Garages(bankOffer, automaticDoor, motorcycleParking, security)

Garages(; bankOffer::Union{Bool, Nothing}=nothing,
          automaticDoor::Union{Bool, Nothing}=nothing,
          motorcycleParking::Union{Bool, Nothing}=nothing,
          security::Union{Bool, Nothing}=nothing)
```

# Examples
```jldoctest
julia> Garages(nothing, true, true, false)
Garages:
	bankOffer => nothing
	automaticDoor => true
	motorcycleParking => true
	security => false

julia> Garages(automaticDoor=true, security=true)
Garages:
	bankOffer => nothing
	automaticDoor => true
	motorcycleParking => nothing
	security => true
```
"""
@kwdef struct Garages <: PropertyFields
    bankOffer::Union{Bool, Nothing}=nothing
    automaticDoor::Union{Bool, Nothing}=nothing
    motorcycleParking::Union{Bool, Nothing}=nothing
    security::Union{Bool, Nothing}=nothing
end



"""
    Premises <: PropertyFields

A struct that stores the premises specific search fields

Each field represents a valid premises search field for the Idealista Search API

# Constructors
```julia

Premises(minSize,
         maxSize,
         virtualTour,
         location,
         corner,
         airConditioning,
         smokeVentilation,
         heating,
         transfer,
         buildingTypes,
         bankOffer)

Premises(; minSize::Union{<:Number, Nothing}=nothing,
           maxSize::Union{<:Number, Nothing}=nothing,
           virtualTour::Union{Bool, Nothing}=nothing,
           location::Union{<:AbstractString, Nothing}=nothing,
           corner::Union{Bool, Nothing}=nothing,
           airConditioning::Union{Bool, Nothing}=nothing,
           smokeVentilation::Union{Bool, Nothing}=nothing,
           heating::Union{Bool, Nothing}=nothing,
           transfer::Union{Bool, Nothing}=nothing,
           buildingTypes::Union{<:AbstractString, Nothing}=nothing,
           bankOffer::Union{Bool, Nothing}=nothing)
```

# Examples
```jldoctest
julia> Premises(70, 120, false, "shoppingcenter", false, true, false, true, false, "industrialBuilding", false)
[ Info: bankOffer only applies in Spain
Premises:
	minSize => 70
	maxSize => 120
	virtualTour => false
	location => shoppingcenter
	corner => false
	airConditioning => true
	smokeVentilation => false
	heating => true
	transfer => false
	buildingTypes => industrialBuilding
	bankOffer => false

julia> Premises(minSize=70, maxSize=120, transfer=false, location="shoppingcenter")
Premises:
	minSize => 70
	maxSize => 120
	virtualTour => nothing
	location => shoppingcenter
	corner => nothing
	airConditioning => nothing
	smokeVentilation => nothing
	heating => nothing
	transfer => false
	buildingTypes => nothing
	bankOffer => nothing
```
"""
@kwdef struct Premises <: PropertyFields
    minSize::Union{<:Number, Nothing}=nothing
    maxSize::Union{<:Number, Nothing}=nothing
    virtualTour::Union{Bool, Nothing}=nothing
    location::Union{<:AbstractString, Nothing}=nothing
    corner::Union{Bool, Nothing}=nothing
    airConditioning::Union{Bool, Nothing}=nothing
    smokeVentilation::Union{Bool, Nothing}=nothing
    heating::Union{Bool, Nothing}=nothing
    transfer::Union{Bool, Nothing}=nothing
    buildingTypes::Union{<:AbstractString, Nothing}=nothing
    bankOffer::Union{Bool, Nothing}=nothing

    function Premises(minSize, maxSize, virtualTour, location, corner, airConditioning, smokeVentilation, heating, transfer, buildingTypes, bankOffer)

        ~isnothing(minSize) && ((60 <= minSize <= 1000) || throw(DomainError(:minSize, "premise size must be between 60 and 1000 m²")))
        ~isnothing(maxSize) && ((60 <= maxSize <= 1000) || throw(DomainError(:maxSize, "premise size must be between 60 and 1000 m²")))
        ~isnothing(location) && ∉(location, ["shoppingcenter", "street", "mezzanine", "underground", "others"]) && throw(DomainError(:location, "location can only take values of shoppingcenter, street, mezzanine, underground or other"))
        ~isnothing(buildingTypes) && ∉(buildingTypes, ["premises", "industrialBuilding"]) && throw(DomainError(:buildingTypes, "buildingTypes can only take values of premises or industrialBuilding"))
        ~isnothing(bankOffer) && @info("bankOffer only applies in Spain")

        new(minSize, maxSize, virtualTour, location, corner, airConditioning, smokeVentilation, heating, transfer, buildingTypes, bankOffer)
    end
end


"""
    Homes <: PropertyFields

A struct that stores the homes specific search fields

Each field represents a valid homes search field for the Idealista Search API

# Constructors
```julia

Homes(minSize,
      maxSize,
      virtualTour,
      flat,
      penthouse,
      duplex,
      studio,
      chalet,
      countryHouse,
      bedrooms,
      bathrooms,
      preservation,
      newDevelopment,
      furnished,
      bankOffer,
      garage,
      terrace,
      exterior,
      elevator,
      swimmingPool,
      airConditioning,
      storeRoom,
      clotheslineSpace,
      builtinWardrobes,
      subTypology)

struct Homes(; minSize::Union{<:Number, Nothing}=nothing,
               maxSize::Union{<:Number, Nothing}=nothing,
               virtualTour::Union{Bool, Nothing}=nothing,
               flat::Union{Bool, Nothing}=nothing,
               penthouse::Union{Bool, Nothing}=nothing,
               duplex::Union{Bool, Nothing}=nothing,
               studio::Union{Bool, Nothing}=nothing,
               chalet::Union{Bool, Nothing}=nothing,
               countryHouse::Union{Bool, Nothing}=nothing,
               bedrooms::Union{<:AbstractString, Nothing}=nothing,
               bathrooms::Union{<:AbstractString, Nothing}=nothing,
               preservation::Union{<:AbstractString, Nothing}=nothing,
               newDevelopment::Union{Bool, Nothing}=nothing,
               furnished::Union{<:AbstractString, Nothing}=nothing,
               bankOffer::Union{Bool, Nothing}=nothing,
               garage::Union{Bool, Nothing}=nothing,
               terrace::Union{Bool, Nothing}=nothing,
               exterior::Union{Bool, Nothing}=nothing,
               elevator::Union{Bool, Nothing}=nothing,
               swimmingPool::Union{Bool, Nothing}=nothing,
               airConditioning::Union{Bool, Nothing}=nothing,
               storeRoom::Union{Bool, Nothing}=nothing,
               clotheslineSpace::Union{Bool, Nothing}=nothing,
               builtinWardrobes::Union{Bool, Nothing}=nothing,
               subTypology::Union{<:AbstractString, Nothing}=nothing)

```

# Examples
```jldoctest

julia> Homes(65, 130, false, true, true, true, true, true, true, "1,2,3,4", "1,2", "good", true, "furnished", false, true, true, false, false, false, false, false, false, true, "independantHouse")
[ Info: bankOffer only applies in Spain
Homes:
	minSize => 65
	maxSize => 130
	virtualTour => false
	flat => true
	penthouse => true
	duplex => true
	studio => true
	chalet => true
	countryHouse => true
	bedrooms => 1,2,3,4
	bathrooms => 1,2
	preservation => good
	newDevelopment => true
	furnished => furnished
	bankOffer => false
	garage => true
	terrace => true
	exterior => false
	elevator => false
	swimmingPool => false
	airConditioning => false
	storeRoom => false
	clotheslineSpace => false
	builtinWardrobes => true
	subTypology => independantHouse


julia> Homes(minSize=70, swimmingPool=false, preservation="renew", subTypology="terracedHouse")
Homes:
	minSize => 70
	maxSize => nothing
	virtualTour => nothing
	flat => nothing
	penthouse => nothing
	duplex => nothing
	studio => nothing
	chalet => nothing
	countryHouse => nothing
	bedrooms => nothing
	bathrooms => nothing
	preservation => renew
	newDevelopment => nothing
	furnished => nothing
	bankOffer => nothing
	garage => nothing
	terrace => nothing
	exterior => nothing
	elevator => nothing
	swimmingPool => false
	airConditioning => nothing
	storeRoom => nothing
	clotheslineSpace => nothing
	builtinWardrobes => nothing
	subTypology => terracedHouse
```
"""
@kwdef struct Homes <: PropertyFields
    minSize::Union{<:Number, Nothing}=nothing
    maxSize::Union{<:Number, Nothing}=nothing
    virtualTour::Union{Bool, Nothing}=nothing
    flat::Union{Bool, Nothing}=nothing
    penthouse::Union{Bool, Nothing}=nothing
    duplex::Union{Bool, Nothing}=nothing
    studio::Union{Bool, Nothing}=nothing
    chalet::Union{Bool, Nothing}=nothing
    countryHouse::Union{Bool, Nothing}=nothing
    bedrooms::Union{<:AbstractString, Nothing}=nothing
    bathrooms::Union{<:AbstractString, Nothing}=nothing
    preservation::Union{<:AbstractString, Nothing}=nothing
    newDevelopment::Union{Bool, Nothing}=nothing
    furnished::Union{<:AbstractString, Nothing}=nothing
    bankOffer::Union{Bool, Nothing}=nothing
    garage::Union{Bool, Nothing}=nothing
    terrace::Union{Bool, Nothing}=nothing
    exterior::Union{Bool, Nothing}=nothing
    elevator::Union{Bool, Nothing}=nothing
    swimmingPool::Union{Bool, Nothing}=nothing
    airConditioning::Union{Bool, Nothing}=nothing
    storeRoom::Union{Bool, Nothing}=nothing
    clotheslineSpace::Union{Bool, Nothing}=nothing
    builtinWardrobes::Union{Bool, Nothing}=nothing
    subTypology::Union{<:AbstractString, Nothing}=nothing

    function Homes(minSize, maxSize, virtualTour, flat, penthouse, duplex, studio, chalet, countryHouse, bedrooms, bathrooms, preservation, newDevelopment, furnished, bankOffer, garage, terrace, exterior, elevator, swimmingPool, airConditioning, storeRoom, clotheslineSpace, builtinWardrobes, subTypology)

        ~isnothing(minSize) && ((60 <= minSize <= 1000) || throw(DomainError(:minSize, "minimum house size must be between 60 and 1000 m²")))
        ~isnothing(maxSize) && ((60 <= maxSize <= 1000) || throw(DomainError(:maxSize, "maximum house size must be between 60 and 1000 m²")))
        ~isnothing(bedrooms) && !(eltype(parse.(Int, split(bedrooms, ","))) <: Int) && throw(ArgumentError("number of bedrooms must be given as a string of integers separate by ,"))
        ~isnothing(bathrooms) && !(eltype(parse.(Int, split(bathrooms, ","))) <: Int) && throw(ArgumentError("number of bathrooms must be given as a string of integers separate by ,"))
        ~isnothing(preservation) && ∉(preservation, ["good", "renew"]) && throw(DomainError(:preservation, "preservation can only take values of good or renew"))
        ~isnothing(furnished) && ∉(furnished, ["furnished", "furnishedKitchen"]) && throw(DomainError(:furnished, "furnished only takes values of furnished or furnishedKitchen"))
        ~isnothing(bankOffer) && @info("bankOffer only applies in Spain")
        ~isnothing(subTypology) && ∉(subTypology, ["independantHouse", "semidetachedHouse", "terracedHouse"]) && throw(DomainError(:subTypology, "subTypology only accepts values of independantHouse, semidetachedHouse or terracedHouse"))

        new(minSize, maxSize, virtualTour, flat, penthouse, duplex, studio, chalet, countryHouse, bedrooms, bathrooms, preservation, newDevelopment, furnished, bankOffer, garage, terrace, exterior, elevator, swimmingPool, airConditioning, storeRoom, clotheslineSpace, builtinWardrobes, subTypology)
    end
end


"""
    Offices <: PropertyFields

A struct that stores the office specific search fields

Each field represents a valid offices search field for the Idealista Search API

# Constructors
```julia

Offices(minSize,
        maxSize,
        layout,
        buildingType,
        garage,
        hotWater,
        heating,
        elevator,
        airConditioning,
        security,
        exterior,
        bankOffer)

Offices(; minSize::Union{<:Number, Nothing}=nothing,
          maxSize::Union{<:Number, Nothing}=nothing,
          layout::Union{<:AbstractString, Nothing}=nothing,
          buildingType::Union{<:AbstractString, Nothing}=nothing,
          garage::Union{Bool, Nothing}=nothing,
          hotWater::Union{Bool, Nothing}=nothing,
          heating::Union{Bool, Nothing}=nothing,
          elevator::Union{Bool, Nothing}=nothing,
          airConditioning::Union{Bool, Nothing}=nothing,
          security::Union{Bool, Nothing}=nothing,
          exterior::Union{Bool, Nothing}=nothing,
          bankOffer::Union{Bool, Nothing}=nothing)
```
# Examples
```jldoctest
julia> Offices(100, 400, "withWalls", "exclusive", false, true, true, true, true, false, false, false)
[ Info: bankOffer only works in Spain
Offices:
	minSize => 100
	maxSize => 400
	layout => withWalls
	buildingType => exclusive
	garage => false
	hotWater => true
	heating => true
	elevator => true
	airConditioning => true
	security => false
	exterior => false
	bankOffer => false


julia> Offices(minSize=100, maxSize=400, layout="withWalls", buildingType="exclusive")
Offices:
	minSize => 100
	maxSize => 400
	layout => withWalls
	buildingType => exclusive
	garage => nothing
	hotWater => nothing
	heating => nothing
	elevator => nothing
	airConditioning => nothing
	security => nothing
	exterior => nothing
	bankOffer => nothing
```
"""

@kwdef struct Offices <: PropertyFields
    minSize::Union{<:Number, Nothing}=nothing
    maxSize::Union{<:Number, Nothing}=nothing
    layout::Union{<:AbstractString, Nothing}=nothing
    buildingType::Union{<:AbstractString, Nothing}=nothing
    garage::Union{Bool, Nothing}=nothing
    hotWater::Union{Bool, Nothing}=nothing
    heating::Union{Bool, Nothing}=nothing
    elevator::Union{Bool, Nothing}=nothing
    airConditioning::Union{Bool, Nothing}=nothing
    security::Union{Bool, Nothing}=nothing
    exterior::Union{Bool, Nothing}=nothing
    bankOffer::Union{Bool, Nothing}=nothing

    function Offices(minSize, maxSize, layout, buildingType, garage, hotWater, heating, elevator, airConditioning, security, exterior, bankOffer)

       ~isnothing(minSize) && ((60 <= minSize <= 1000) || throw(DomainError(:minSize, "office size must be between 60 and 1000 m²")))
       ~isnothing(maxSize) && ((60 <= maxSize <= 1000) || throw(DomainError(:maxSize, "office size must be between 60 and 1000 m²")))
       ~isnothing(layout) && ∉(layout, ["withWalls", "openPlan"]) && throw(DomainError(:layout, "layout can only take vues withWalls and openPlan"))
       ~isnothing(buildingType) && ∉(buildingType, ["exclusive", "mixed"]) && throw(DomainError(:buildingType, "buildingType can only take values of exclusive or mixed"))
       ~isnothing(bankOffer) && @info("bankOffer only works in Spain")

       new(minSize, maxSize, layout, buildingType, garage, hotWater, heating, elevator, airConditioning, security, exterior, bankOffer)
   end

end



"""
    Bedrooms <: PropertyFields

A struct that stores the bedrooms specific search fields

Each field represents a valid bedrooms search field for the Idealista Search API

# Constructors
```julia

Bedrooms(housemates,
         smokePolicy,
         petsPolicy,gayPartners,
         newGender)

Bedrooms(; housemates::Union{<:AbstractString, Nothing}=nothing,
           smokePolicy::Union{<:AbstractString, Nothing}=nothing,
           petsPolicy::Union{<:AbstractString, Nothing}=nothing,
           gayPartners::Union{Bool, Nothing}=nothing,
           newGender::Union{<:AbstractString, Nothing}=nothing)
```

# Examples
```jldoctest
julia> Bedrooms("2,4", "disallowed", "disallowed", true, "male")
Bedrooms:
	housemates => 2,4
	smokePolicy => disallowed
	petsPolicy => disallowed
	gayPartners => true
	newGender => male

julia> Bedrooms(housemates="2,4", smokePolicy="disallowed", petsPolicy="disallowed", gayPartners=true, newGender="male")
Bedrooms:
	housemates => 2,4
	smokePolicy => disallowed
	petsPolicy => disallowed
	gayPartners => true
	newGender => male
```
"""

@kwdef struct Bedrooms <: PropertyFields
    housemates::Union{<:AbstractString, Nothing}=nothing
    smokePolicy::Union{<:AbstractString, Nothing}=nothing
    petsPolicy::Union{<:AbstractString, Nothing}=nothing
    gayPartners::Union{Bool, Nothing}=nothing
    newGender::Union{<:AbstractString, Nothing}=nothing

    function Bedrooms(housemates, smokePolicy, petsPolicy, gayPartners, newGender)

        ~isnothing(housemates) && !(eltype(parse.(Int, split(housemates, ","))) <: Int) && throw(ArgumentError("housemates must be given as a string of integers separate by ,"))
        ~isnothing(smokePolicy) && ∉(smokePolicy, ["allowed", "disallowed"]) && throw(DomainError(:smokePolicy, "the only valid values for smokePolicy are allowed or disallowed"))
        ~isnothing(petsPolicy) && ∉(petsPolicy, ["allowed", "disallowed"]) && throw(DomainError(:petsPolicy, "the only valid values for petsPolicy are allowed or disallowed"))
        ~isnothing(newGender) && ∉(newGender, ["male", "female"]) && throw(DomainError(:newGender, "newGender can only take values of male or female"))

        new(housemates, smokePolicy, petsPolicy, gayPartners, newGender)
     end
end

function Base.:show(io::IO, ::MIME"text/plain", s::SearchFields)
    println(io, "$(typeof(s).name.wrapper):")
    for fname in fieldnames(typeof(s))
        println(io, "\t$fname => $(getfield(s, fname))")
    end
end
