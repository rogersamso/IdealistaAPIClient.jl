var documenterSearchIndex = {"docs":
[{"location":"functions/","page":"Functions","title":"Functions","text":"CurrentModule = IdealistaAPIClient","category":"page"},{"location":"functions/#Functions","page":"Functions","title":"Functions","text":"","category":"section"},{"location":"functions/#Index","page":"Functions","title":"Index","text":"","category":"section"},{"location":"functions/","page":"Functions","title":"Functions","text":"Pages = [\"functions.md\"]","category":"page"},{"location":"functions/","page":"Functions","title":"Functions","text":"Modules = [IdealistaAPIClient]\nOrder   = [:function]","category":"page"},{"location":"functions/#IdealistaAPIClient.get_token-Tuple{}","page":"Functions","title":"IdealistaAPIClient.get_token","text":"get_token()\n\nReturn Idealista Search API parsed response for token request\n\nNotes\n\nAPIKEY and SECRET must be defined as environmental variables. Generated tokens get cached in tempdir, and any new calls to the get_token function before the expiration date will return the cached value\n\nExamples\n\njulia>get_token()\n[ Info: Getting new access token\nDict{String, Any} with 5 entries:\n  \"access_token\" => \"token_value\"\n  \"token_type\"   => \"bearer\"\n  \"scope\"        => \"read\"\n  \"expires_in\"   => DateTime(\"2022-08-14T03:07:24.573\")\n  \"jti\"          => \"jti_value\"\n\n\n\n\n\n\n","category":"method"},{"location":"functions/#IdealistaAPIClient.process_response-Tuple{Dict{String, Any}}","page":"Functions","title":"IdealistaAPIClient.process_response","text":"process_response(response)\n\nProcess the response of the Idealista Search API\n\nGoes through the dictionary of the parsed Idealista Search API response and instantiates a Response object\n\nExamples\n\n\n\n\n\n","category":"method"},{"location":"functions/#IdealistaAPIClient.search","page":"Functions","title":"IdealistaAPIClient.search","text":"search(base_search::Search, property::Union{<:PropertySearchFields, Nothing}=nothing; token::Union{Dict{String, Any}, Nothing}=nothing)\n\nPerform a search in the Idealista Search API\n\nThis method uses Search and property types instances as arguments\n\nArguments\n\nbase_search: Search object\nproperty: Homes, Premises, Garages, Bedrooms or Offices object\n\nKeyword Argyments\n\ntoken_d: Dict containing the API response for a token request\n\nExamples\n\njulia>search(Search(country=\"es\", center=\"40.430,-3.702\", propertyType=\"homes\", distance=15000, operation=\"sale\"), Homes(bedrooms=\"1,2,3,4\", swimmingPool=true))\n[ Info: Getting new access token\nDict{String, Any} with 12 entries:\n  \"hiddenResults\"      => false\n  \"itemsPerPage\"       => 20\n  \"upperRangePosition\" => 20\n  \"totalPages\"         => 206\n  \"paginable\"          => true\n  \"summary\"            => Any[\"Comprar\", \"Viviendas\", \"barrio Trafalgar, Madrid\", \"Todos los…\n  \"total\"              => 4118\n  \"lowerRangePosition\" => 0\n  \"alertName\"          => \"Viviendas en barrio Trafalgar, Madrid\"\n  \"elementList\"        => Any[Dict{String, Any}(\"rooms\"=>6, \"propertyCode\"=>\"98324891\", \"num…\n  \"numPaginations\"     => 0\n  \"actualPage\"         => 1\n\n\n\n\n\n\n","category":"function"},{"location":"functions/#IdealistaAPIClient.search-Tuple{}","page":"Functions","title":"IdealistaAPIClient.search","text":"search(base_search::Search, property::Union{<:PropertySearchFields, Nothing}=nothing; token::Union{Dict{String, Any}, Nothing}=nothing)\n\nPerform a search in the Idealista Search API\n\nThis method uses keyword arguments corresponding to valid search fields of the Idealista Search API\n\nKeyword Argyments\n\ntoken_d: Dict containing the API response for a token request\nkwargs: search fields of the Idealista Search API\n\nExamples\n\njulia>search(country=\"es\", center=\"40.430,-3.702\", propertyType=\"homes\", distance=15000, operation=\"sale\", bedrooms=\"1,2,3,4\", swimmingPool=true)\n[ Info: Getting new access token\nDict{String, Any} with 12 entries:\n  \"hiddenResults\"      => false\n  \"itemsPerPage\"       => 20\n  \"upperRangePosition\" => 20\n  \"totalPages\"         => 206\n  \"paginable\"          => true\n  \"summary\"            => Any[\"Comprar\", \"Viviendas\", \"barrio Trafalgar, Madrid\", \"Todos los…\n  \"total\"              => 4118\n  \"lowerRangePosition\" => 0\n  \"alertName\"          => \"Viviendas en barrio Trafalgar, Madrid\"\n  \"elementList\"        => Any[Dict{String, Any}(\"rooms\"=>6, \"propertyCode\"=>\"98324891\", \"num…\n  \"numPaginations\"     => 0\n  \"actualPage\"         => 1\n\n\n\n\n\n\n","category":"method"},{"location":"functions/#IdealistaAPIClient.stringdict_to_nt-Union{Tuple{Dict{String, T}}, Tuple{T}} where T","page":"Functions","title":"IdealistaAPIClient.stringdict_to_nt","text":"stringdict_to_nt(::Dict{String, T})\n\nConvert a Dict with String keys into a NamedTuple\n\nExamples\n\nd = Dict(\"a\"=>2, \"b\"=>3)\n\nstringdict_to_nt(d)\n(a=2, b=3)\n\n\n\n\n\n","category":"method"},{"location":"functions/#IdealistaAPIClient.valid_fields-Tuple{Type}","page":"Functions","title":"IdealistaAPIClient.valid_fields","text":"valid_fields(T::Type; indent::Int=0)\n\nPrint fieldnames of type T\n\nPrints fieldnames of the passed type to standard output\n\nKeyword Arguments\n\nindent: number of tabs of indentation\n\nExamples\n\njulia>valid_fields(Garages)\nbankOffer\nautomaticDoor\nmotorcycleParking\nsecurity\n\n\n\n\n\n\n","category":"method"},{"location":"functions/#IdealistaAPIClient.valid_fields-Tuple{}","page":"Functions","title":"IdealistaAPIClient.valid_fields","text":"valid_fields(;indent::Int=1)\n\nPrints fieldnames of all SearchFields subtypes\n\nPrints to stdout names and fieldnames of subtypes of SearchFields\n\nKeyword Arguments\n\nindent: number of tabs of indentation\n\nExamples\n\njulia>valid_fields()\nSearch\n\tcountry\n\toperation\n\tpropertyType\n\tcenter\n\tdistance\n\tlocationId\n\tmaxItems\n\tnumPage\n\tmaxPrice\n\tminPrice\n\tsinceDate\n\torder\n\tsort\n\tadIds\n\thasMultimedia\nBedrooms\n\thousemates\n\tsmokePolicy\n\tpetsPolicy\n\tgayPartners\n\tnewGender\nGarages\n\tbankOffer\n\tautomaticDoor\n\tmotorcycleParking\n\tsecurity\nHomes\n\tminSize\n\tmaxSize\n\tvirtualTour\n\tflat\n\tpenthouse\n\tduplex\n\tstudio\n\tchalet\n\tcountryHouse\n\tbedrooms\n\tbathrooms\n\tpreservation\n\tnewDevelopment\n\tfurnished\n\tbankOffer\n\tgarage\n\tterrace\n\texterior\n\televator\n\tswimmingPool\n\tairConditioning\n\tstoreRoom\n\tclotheslineSpace\n\tbuiltinWardrobes\n\tsubTypology\nOffices\n\tminSize\n\tmaxSize\n\tlayout\n\tbuildingType\n\tgarage\n\thotWater\n\theating\n\televator\n\tairConditioning\n\tsecurity\n\texterior\n\tbankOffer\nPremises\n\tminSize\n\tmaxSize\n\tvirtualTour\n\tlocation\n\tcorner\n\tairConditioning\n\tsmokeVentilation\n\theating\n\ttransfer\n\tbuildingTypes\n\tbankOffer\n\n\n\n\n\n\n","category":"method"},{"location":"usage/#Installation-instructions","page":"Usage","title":"Installation instructions","text":"","category":"section"},{"location":"usage/","page":"Usage","title":"Usage","text":"At the Julia REPL:","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"using Pkg \n\nPkg.add(\"IdealistaAPIClient\")\n","category":"page"},{"location":"usage/#Usage","page":"Usage","title":"Usage","text":"","category":"section"},{"location":"usage/","page":"Usage","title":"Usage","text":"There are two interfaces to perform searches, one using keyword arguments, and another one using the Search and PropertyFields subtypes.","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"Here is an example of the keywords inteface:","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"using IdealistaAPIClient\n\n# see list of valid fields for each property type\n# note that only some of the Search type fields must be passed, while the rest are optional (see the Valid search fields section below)\nvalid_fields()\n\n# define search fields\nsearch_fields = (country=\"es\", center=\"40.430,-3.702\", propertyType=\"homes\", distance=15000, operation=\"sale\", bedrooms=\"1,2,3,4\", swimmingPool=true)\n\nresponse_body = search(;search_fields...)\n","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"Here is the alternative way to search for a property:","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"using IdealistaAPIClient\n\n# Instantiate the Search and Homes structs\nsearch_fields = Search(country=\"es\", center=\"40.430,-3.702\", propertyType=\"homes\", distance=15000, operation=\"sale\")\n\nhome_fields = Homes(bedrooms=\"1,2,3,4\", swimmingPool=true)\n\nresponse_body = search(search_fields, home_fields)\n","category":"page"},{"location":"usage/","page":"Usage","title":"Usage","text":"The response body, as expected, is the body of the response of our request, in the form of a dictionary. The response can be then turned into a Response object by passing it to the process_response function.","category":"page"},{"location":"#IdealistaAPIClient.jl","page":"Introduction","title":"IdealistaAPIClient.jl","text":"","category":"section"},{"location":"","page":"Introduction","title":"Introduction","text":"IdealistaAPIClient is a simple julia client for the Idealista Search API.","category":"page"},{"location":"#Index","page":"Introduction","title":"Index","text":"","category":"section"},{"location":"","page":"Introduction","title":"Introduction","text":"   Pages = [\n    \"usage.md\",\n    \"functions.md\",\n    \"types.md\",\n   ]","category":"page"},{"location":"types/","page":"Types","title":"Types","text":"CurrentModule = IdealistaAPIClient","category":"page"},{"location":"types/","page":"Types","title":"Types","text":"Pages = [\"types.md\"]","category":"page"},{"location":"types/#Types-specification","page":"Types","title":"Types specification","text":"","category":"section"},{"location":"types/","page":"Types","title":"Types","text":"Modules = [IdealistaAPIClient]\nOrder = [:type]","category":"page"},{"location":"types/#IdealistaAPIClient.Bedrooms","page":"Types","title":"IdealistaAPIClient.Bedrooms","text":"Bedrooms <: PropertySearchFields\n\nA struct that stores the bedrooms specific search fields\n\nEach field represents a valid bedrooms search field for the Idealista Search API\n\nConstructors\n\n\nBedrooms(housemates,\n         smokePolicy,\n         petsPolicy,gayPartners,\n         newGender)\n\nBedrooms(; housemates::Union{<:AbstractString, Nothing}=nothing,\n           smokePolicy::Union{<:AbstractString, Nothing}=nothing,\n           petsPolicy::Union{<:AbstractString, Nothing}=nothing,\n           gayPartners::Union{Bool, Nothing}=nothing,\n           newGender::Union{<:AbstractString, Nothing}=nothing)\n\nExamples\n\njulia> Bedrooms(\"2,4\", \"disallowed\", \"disallowed\", true, \"male\")\nBedrooms:\n\thousemates => 2,4\n\tsmokePolicy => disallowed\n\tpetsPolicy => disallowed\n\tgayPartners => true\n\tnewGender => male\n\njulia> Bedrooms(housemates=\"2,4\", smokePolicy=\"disallowed\", petsPolicy=\"disallowed\", gayPartners=true, newGender=\"male\")\nBedrooms:\n\thousemates => 2,4\n\tsmokePolicy => disallowed\n\tpetsPolicy => disallowed\n\tgayPartners => true\n\tnewGender => male\n\n\n\n\n\n","category":"type"},{"location":"types/#IdealistaAPIClient.DetailedType","page":"Types","title":"IdealistaAPIClient.DetailedType","text":"DetailedType <: ResponseFields\n\nA struct that stores the detailed Type of properties returned by the Idealista Search API\n\nConstructors\n\n\nDetailedType(typology, subTypology)\n\nDetailedType(; typology::String,\n               subTypology::Union{String, Nothing}=nothing)\n\n\n\n\n\n","category":"type"},{"location":"types/#IdealistaAPIClient.Element","page":"Types","title":"IdealistaAPIClient.Element","text":"Element <: ResponseFields\n\nGeneric response fields for all property types\n\nNotes\n\nIn the future there should be diferent types for each property type (i.e. Homes, Offices, Premses, Bedrooms and Garages)\n\n\n\n\n\n","category":"type"},{"location":"types/#IdealistaAPIClient.Garages","page":"Types","title":"IdealistaAPIClient.Garages","text":"Garages <: PropertySearchFields\n\nA struct that stores the garage specific search fields\n\nEach field represents a valid garages search field for the Idealista Search API\n\nConstructors\n\n\nGarages(bankOffer, automaticDoor, motorcycleParking, security)\n\nGarages(; bankOffer::Union{Bool, Nothing}=nothing,\n          automaticDoor::Union{Bool, Nothing}=nothing,\n          motorcycleParking::Union{Bool, Nothing}=nothing,\n          security::Union{Bool, Nothing}=nothing)\n\nExamples\n\njulia> Garages(nothing, true, true, false)\nGarages:\n\tbankOffer => nothing\n\tautomaticDoor => true\n\tmotorcycleParking => true\n\tsecurity => false\n\njulia> Garages(automaticDoor=true, security=true)\nGarages:\n\tbankOffer => nothing\n\tautomaticDoor => true\n\tmotorcycleParking => nothing\n\tsecurity => true\n\n\n\n\n\n","category":"type"},{"location":"types/#IdealistaAPIClient.Homes","page":"Types","title":"IdealistaAPIClient.Homes","text":"Homes <: PropertySearchFields\n\nA struct that stores the homes specific search fields\n\nEach field represents a valid homes search field for the Idealista Search API\n\nConstructors\n\n\nHomes(minSize,\n      maxSize,\n      virtualTour,\n      flat,\n      penthouse,\n      duplex,\n      studio,\n      chalet,\n      countryHouse,\n      bedrooms,\n      bathrooms,\n      preservation,\n      newDevelopment,\n      furnished,\n      bankOffer,\n      garage,\n      terrace,\n      exterior,\n      elevator,\n      swimmingPool,\n      airConditioning,\n      storeRoom,\n      clotheslineSpace,\n      builtinWardrobes,\n      subTypology)\n\nstruct Homes(; minSize::Union{<:Number, Nothing}=nothing,\n               maxSize::Union{<:Number, Nothing}=nothing,\n               virtualTour::Union{Bool, Nothing}=nothing,\n               flat::Union{Bool, Nothing}=nothing,\n               penthouse::Union{Bool, Nothing}=nothing,\n               duplex::Union{Bool, Nothing}=nothing,\n               studio::Union{Bool, Nothing}=nothing,\n               chalet::Union{Bool, Nothing}=nothing,\n               countryHouse::Union{Bool, Nothing}=nothing,\n               bedrooms::Union{<:AbstractString, Nothing}=nothing,\n               bathrooms::Union{<:AbstractString, Nothing}=nothing,\n               preservation::Union{<:AbstractString, Nothing}=nothing,\n               newDevelopment::Union{Bool, Nothing}=nothing,\n               furnished::Union{<:AbstractString, Nothing}=nothing,\n               bankOffer::Union{Bool, Nothing}=nothing,\n               garage::Union{Bool, Nothing}=nothing,\n               terrace::Union{Bool, Nothing}=nothing,\n               exterior::Union{Bool, Nothing}=nothing,\n               elevator::Union{Bool, Nothing}=nothing,\n               swimmingPool::Union{Bool, Nothing}=nothing,\n               airConditioning::Union{Bool, Nothing}=nothing,\n               storeRoom::Union{Bool, Nothing}=nothing,\n               clotheslineSpace::Union{Bool, Nothing}=nothing,\n               builtinWardrobes::Union{Bool, Nothing}=nothing,\n               subTypology::Union{<:AbstractString, Nothing}=nothing)\n\n\nExamples\n\njulia> Homes(65, 130, false, true, true, true, true, true, true, \"1,2,3,4\", \"1,2\", \"good\", true, \"furnished\", false, true, true, false, false, false, false, false, false, true, \"independantHouse\")\n[ Info: bankOffer only applies in Spain\nHomes:\n\tminSize => 65\n\tmaxSize => 130\n\tvirtualTour => false\n\tflat => true\n\tpenthouse => true\n\tduplex => true\n\tstudio => true\n\tchalet => true\n\tcountryHouse => true\n\tbedrooms => 1,2,3,4\n\tbathrooms => 1,2\n\tpreservation => good\n\tnewDevelopment => true\n\tfurnished => furnished\n\tbankOffer => false\n\tgarage => true\n\tterrace => true\n\texterior => false\n\televator => false\n\tswimmingPool => false\n\tairConditioning => false\n\tstoreRoom => false\n\tclotheslineSpace => false\n\tbuiltinWardrobes => true\n\tsubTypology => independantHouse\n\n\njulia> Homes(minSize=70, swimmingPool=false, preservation=\"renew\", subTypology=\"terracedHouse\")\nHomes:\n\tminSize => 70\n\tmaxSize => nothing\n\tvirtualTour => nothing\n\tflat => nothing\n\tpenthouse => nothing\n\tduplex => nothing\n\tstudio => nothing\n\tchalet => nothing\n\tcountryHouse => nothing\n\tbedrooms => nothing\n\tbathrooms => nothing\n\tpreservation => renew\n\tnewDevelopment => nothing\n\tfurnished => nothing\n\tbankOffer => nothing\n\tgarage => nothing\n\tterrace => nothing\n\texterior => nothing\n\televator => nothing\n\tswimmingPool => false\n\tairConditioning => nothing\n\tstoreRoom => nothing\n\tclotheslineSpace => nothing\n\tbuiltinWardrobes => nothing\n\tsubTypology => terracedHouse\n\n\n\n\n\n","category":"type"},{"location":"types/#IdealistaAPIClient.Offices","page":"Types","title":"IdealistaAPIClient.Offices","text":"Offices <: PropertySearchFields\n\nA struct that stores the office specific search fields\n\nEach field represents a valid offices search field for the Idealista Search API\n\nConstructors\n\n\nOffices(minSize,\n        maxSize,\n        layout,\n        buildingType,\n        garage,\n        hotWater,\n        heating,\n        elevator,\n        airConditioning,\n        security,\n        exterior,\n        bankOffer)\n\nOffices(; minSize::Union{<:Number, Nothing}=nothing,\n          maxSize::Union{<:Number, Nothing}=nothing,\n          layout::Union{<:AbstractString, Nothing}=nothing,\n          buildingType::Union{<:AbstractString, Nothing}=nothing,\n          garage::Union{Bool, Nothing}=nothing,\n          hotWater::Union{Bool, Nothing}=nothing,\n          heating::Union{Bool, Nothing}=nothing,\n          elevator::Union{Bool, Nothing}=nothing,\n          airConditioning::Union{Bool, Nothing}=nothing,\n          security::Union{Bool, Nothing}=nothing,\n          exterior::Union{Bool, Nothing}=nothing,\n          bankOffer::Union{Bool, Nothing}=nothing)\n\nExamples\n\njulia> Offices(100, 400, \"withWalls\", \"exclusive\", false, true, true, true, true, false, false, false)\n[ Info: bankOffer only applies in Spain\nOffices:\n\tminSize => 100\n\tmaxSize => 400\n\tlayout => withWalls\n\tbuildingType => exclusive\n\tgarage => false\n\thotWater => true\n\theating => true\n\televator => true\n\tairConditioning => true\n\tsecurity => false\n\texterior => false\n\tbankOffer => false\n\n\njulia> Offices(minSize=100, maxSize=400, layout=\"withWalls\", buildingType=\"exclusive\")\nOffices:\n\tminSize => 100\n\tmaxSize => 400\n\tlayout => withWalls\n\tbuildingType => exclusive\n\tgarage => nothing\n\thotWater => nothing\n\theating => nothing\n\televator => nothing\n\tairConditioning => nothing\n\tsecurity => nothing\n\texterior => nothing\n\tbankOffer => nothing\n\n\n\n\n\n","category":"type"},{"location":"types/#IdealistaAPIClient.ParkingSpace","page":"Types","title":"IdealistaAPIClient.ParkingSpace","text":"ParkingSpace <: ResponseFields\n\nA struct that stores the details of parking spaces returned by the Idealista Search API\n\nConstructors\n\n\nParkingSpace(hasParkingSpace, isParkingSpaceIncludedInPrice, parkingSpacePrice)\n\nParkingSpace(; hasParkingSpace::Bool,\n               isParkingSpaceIncludedInPrice::Union{Bool, Nothing}=nothing,\n               parkingSpacePrice::Union{Number, Nothing}=nothing)\n\n\n\n\n\n\n","category":"type"},{"location":"types/#IdealistaAPIClient.Premises","page":"Types","title":"IdealistaAPIClient.Premises","text":"Premises <: PropertySearchFields\n\nA struct that stores the premises specific search fields\n\nEach field represents a valid premises search field for the Idealista Search API\n\nConstructors\n\n\nPremises(minSize,\n         maxSize,\n         virtualTour,\n         location,\n         corner,\n         airConditioning,\n         smokeVentilation,\n         heating,\n         transfer,\n         buildingTypes,\n         bankOffer)\n\nPremises(; minSize::Union{<:Number, Nothing}=nothing,\n           maxSize::Union{<:Number, Nothing}=nothing,\n           virtualTour::Union{Bool, Nothing}=nothing,\n           location::Union{<:AbstractString, Nothing}=nothing,\n           corner::Union{Bool, Nothing}=nothing,\n           airConditioning::Union{Bool, Nothing}=nothing,\n           smokeVentilation::Union{Bool, Nothing}=nothing,\n           heating::Union{Bool, Nothing}=nothing,\n           transfer::Union{Bool, Nothing}=nothing,\n           buildingTypes::Union{<:AbstractString, Nothing}=nothing,\n           bankOffer::Union{Bool, Nothing}=nothing)\n\nExamples\n\njulia> Premises(70, 120, false, \"shoppingcenter\", false, true, false, true, false, \"industrialBuilding\", false)\n[ Info: bankOffer only applies in Spain\nPremises:\n\tminSize => 70\n\tmaxSize => 120\n\tvirtualTour => false\n\tlocation => shoppingcenter\n\tcorner => false\n\tairConditioning => true\n\tsmokeVentilation => false\n\theating => true\n\ttransfer => false\n\tbuildingTypes => industrialBuilding\n\tbankOffer => false\n\njulia> Premises(minSize=70, maxSize=120, transfer=false, location=\"shoppingcenter\")\nPremises:\n\tminSize => 70\n\tmaxSize => 120\n\tvirtualTour => nothing\n\tlocation => shoppingcenter\n\tcorner => nothing\n\tairConditioning => nothing\n\tsmokeVentilation => nothing\n\theating => nothing\n\ttransfer => false\n\tbuildingTypes => nothing\n\tbankOffer => nothing\n\n\n\n\n\n","category":"type"},{"location":"types/#IdealistaAPIClient.Response","page":"Types","title":"IdealistaAPIClient.Response","text":"Response <: ResponseFields\n\nA struct that stores the Idealista Search API response fields\n\nConstructors\n\n\nResponse(actualPage,\n         itemsPerPage,\n         lowerRangePosition,\n         upperRangePosition,\n         paginable,\n         numPaginations,\n         summary,\n         total,\n         totalPages,\n         elementList,\n         alertName,\n         hiddenResults)\n\n\nResponse(; actualPage::Int64,\n           itemsPerPage::Int64,\n           lowerRangePosition::Int64,\n           upperRangePosition::Int64,\n           paginable::Bool,\n           numPaginations::Int64,\n           summary::Vector{String},\n           total::Int64,\n           totalPages::Int64,\n           elementList::Vector{Element},\n           alertName::String,\n           hiddenResults::Bool)\n\n\n\n\n\n\n","category":"type"},{"location":"types/#IdealistaAPIClient.Search","page":"Types","title":"IdealistaAPIClient.Search","text":"Search <: SearchFields\n\nA struct that stores the basic (non-property-type specific) search fields of the Idealista Search API\n\nEach field represents a valid base search field for the Idealista Search API. The country, operation, propertyType and center + distance or center + locationId are mandatory\n\nConstructors\n\n\nSearch(country,\n       operation,\n       propertyType,\n       center,\n       maxItems,\n       numPage,\n       maxPrice,\n       minPrice,\n       sinceDate,\n       orderg,\n       sort,\n       adIds,\n       hasMultimedia,\n       distance,\n       locationId,\n       locale)\n\nSearch(; country::String,\n         operation::String,\n         propertyType::String,\n         center::String,\n         maxItems::Union{<:Int, Nothing}=nothing,\n         numPage::Union{<:Int, Nothing}=nothing,\n         maxPrice::Union{<:Number, Nothing}=nothing,\n         minPrice::Union{<:Number, Nothing}=nothing,\n         sinceDate::Union{<:AbstractString, Nothing}=nothing,\n         order::Union{<:AbstractString, Nothing}=nothing,\n         sort::Union{<:AbstractString, Nothing}=nothing,\n         adIds::Union{<:Int, Nothing}=nothing,\n         hasMultimedia::Union{Bool, Nothing}=nothing,\n         distance::Union{<:Int, Nothing}=nothing,\n         locationId::Union{<:AbstractString, Nothing}=nothing,\n         locale::String)\n\nExamples\n\njulia> Search(\"es\", \"sale\", \"homes\", \"42.0,-3.7\",  nothing, nothing, nothing, nothing, nothing, nothing, nothing, nothing, nothing, 15000,  nothing, \"ca\")\nSearch:\n\tcountry => es\n\toperation => sale\n\tpropertyType => homes\n\tcenter => 42.0,-3.7\n\tmaxItems => nothing\n\tnumPage => nothing\n\tmaxPrice => nothing\n\tminPrice => nothing\n\tsinceDate => nothing\n\torder => nothing\n\tsort => nothing\n\tadIds => nothing\n\thasMultimedia => nothing\n\tdistance => 15000\n\tlocationId => nothing\n\tlocale => ca\n\njulia> Search(country=\"it\", operation=\"sale\", propertyType=\"homes\", center=\"42.0,-3.7\", locale=\"es\", distance=15000)\nSearch:\n\tcountry => it\n\toperation => sale\n\tpropertyType => homes\n\tcenter => 42.0,-3.7\n\tmaxItems => nothing\n\tnumPage => nothing\n\tmaxPrice => nothing\n\tminPrice => nothing\n\tsinceDate => nothing\n\torder => nothing\n\tsort => nothing\n\tadIds => nothing\n\thasMultimedia => nothing\n\tdistance => 15000\n\tlocationId => nothing\n\tlocale => es\n\njulia> Search(\"it\", \"sale\", \"homes\", \"42.0,-3.7\", locale=\"es\", distance=15000)\nSearch:\n\tcountry => it\n\toperation => sale\n\tpropertyType => homes\n\tcenter => 42.0,-3.7\n\tmaxItems => nothing\n\tnumPage => nothing\n\tmaxPrice => nothing\n\tminPrice => nothing\n\tsinceDate => nothing\n\torder => nothing\n\tsort => nothing\n\tadIds => nothing\n\thasMultimedia => nothing\n\tdistance => 15000\n\tlocationId => nothing\n\tlocale => es\n\n\n\n\n\n","category":"type"}]
}