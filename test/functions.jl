using IdealistaAPIClient: struct_to_dict, valid_token
using Dates

@testset "struct_to_dict" begin
    
    t = Homes(minSize=90, maxSize=150)
    d = struct_to_dict(t)
    @test isa(d, Dict{String, Int})
    @test haskey(d, "minSize")
    @test ~haskey(d, "storeRoom")

end

@testset "valid_fields" begin

    @test valid_fields(Garages) == fieldnames(Garages)
    
    # without arguments
    all_types = valid_fields()
    @test isa(all_types, Dict)
    @test sort(map(x-> x.name.name, collect(keys(all_types)))) == [:Bedrooms, :Garages, :Homes, :Offices, :Premises,  :Search]

end

@testset "valid_token" begin
    
    missing_date = Dict("access_token"=>"token")
    @test_throws UndefKeywordError valid_token(missing_date)
    
    missing_token = Dict("expires_in"=> DateTime("2020-01-01", "yyyy-mm-dd"))
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
