using IdealistaAPIClient: struct_to_dict, valid_token, validate_search_fields

@testset "struct_to_dict" begin
    
    t = Homes(minSize=90, maxSize=150)
    d = struct_to_dict(t)
    @test isa(d, Dict{String, Int})
    @test haskey(d, "minSize")
    @test ~haskey(d, "storeRoom")

end


@testset "valid_token" begin
    
    missing_date = Dict("access_token"=>"token")
    @test_throws UndefKeywordError valid_token(missing_date)
    
    missing_token = Dict("expires_in"=> Dates.DateTime("2020-01-01", "yyyy-mm-dd"))
    @test_throws UndefKeywordError valid_token(missing_token)

    wrong_date_type = Dict("access_token" => "token",
                           "expires_in" => "2020-01-01")
    @test_throws ErrorException valid_token(wrong_date_type)
    
    expired_token = deserialize(joinpath(dir, "token.bin"))
    @test valid_token(expired_token) == false 

    soon = Dates.now() + Minute(60)
    valid =  Dict("access_token" => "token",
                  "expires_in" => soon)
    @test valid_token(valid) == true

end


@testset "validate_search_fields" begin

    t = (country="it", operation="sale", center="42.0,-3.7", distance=15000, propertyType="homes", maxSize=150, minSize=nothing)
    result1 = validate_search_fields(;t...)
    @test isa(result1, Dict{String, Any})

    sorted_keys = ["center", "country", "distance", "maxSize", "operation", "propertyType"]
    @test sort(collect(keys(result1))) == sorted_keys

    s = Search(;country="it", operation="sale", center="42.0,-3.7", distance=15000, propertyType="homes")
    p = Homes(maxSize=150)
    
    result2 = validate_search_fields(s, p)
    @test isa(result2, Dict{String, Any})
    @test sort(collect(keys(result2))) == sorted_keys

end
