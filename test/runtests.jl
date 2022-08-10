using Test
using IdealistaAPIClient

@testset "generate credentials" begin
    @test 2 == 2


end


@testset "request token" begin
    @test 1 == 1

end

@testset "Search type" begin
    
    # missing required keyword arguments
    @test_throws UndefKeywordError Search(country="pt")
    @test_throws UndefKeywordError Search(country="pt",
                                          operation="sale")
    @test_throws UndefKeywordError Search(country="uk",
                                          operation="sale",
                                          propertyType="homes")
    # either distance of locationId are required
    @test_throws ErrorException Search(country="uk",
                                       operation="sale",
                                       propertyType="homes",
                                       center="42.3,-3.7")
    
    # distance and locationId both defined
    @test_throws ErrorException Search(country="es",
                                       operation="sale",
                                       propertyType="homes",
                                       center="42.3,-3.7",
                                       distance=15000,
                                       locationId="hello") 
    s = Search(country="es",
                 operation="sale", 
                 propertyType="homes", 
                 center="42.3,-3.7",
                 distance=15000) 
    @test isa(s, Search)
    
    # country not es, pt or it
    @test_throws DomainError Search(country="uk",
                                    operation="sale",
                                    propertyType="homes",
                                    center="42.3,-3.7",
                                    distance=15000)

    # operation not sale or rent
    @test_throws DomainError Search(country="it",
                                    operation="invalid operation",
                                    propertyType="homes",
                                    center="42.3,-3.7",
                                    distance=15000)

    # invalid propertyType 
    @test_throws DomainError Search(country="it",
                                    operation="sale",
                                    propertyType="palace",
                                    center="42.3,-3.7",
                                    distance=15000)

    # invalid sort (asc or desc) 
    @test_throws DomainError Search(country="it",
                                    operation="sale",
                                    propertyType="offices",
                                    center="42.3,-3.7",
                                    distance=15000,
                                    sort="ascending")
    
    # invalid sinceData (W, M, T, Y) 
    @test_throws DomainError Search(country="it",
                                    operation="sale",
                                    propertyType="offices",
                                    center="42.3,-3.7",
                                    distance=15000,
                                    sinceDate="forever")
end

@testset "Garages type" begin
    
    empty = Garages()
    @test isa(empty, IdealistaAPIClient.PropertyFields)
    @test isnothing(empty.automaticDoor)
    
    # positional args
    positional = Garages(true, true, false, nothing)
    @test isnothing(positional.security)
    

    # keyword args
    security = Garages(;security=true)
    @test security.security == true
    @test isnothing(security.automaticDoor)

end

