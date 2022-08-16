using Test
using IdealistaAPIClient


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
    
    # bedrooms and sale don't mix well
    @test_throws DomainError Search(country="es",
                                    center="40.430,-3.702",
                                    propertyType="bedrooms",
                                    distance=15000,
                                    operation="sale")
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
    
    # method error
    @test_throws MethodError Garages(security="true")

    @test_logs (:info, "bankOffer only applies in Spain") Garages(bankOffer=true)

end


@testset "Premises type" begin
    
    # empty initialization
    empty = Premises()
    @test isa(empty, Premises)

    # positional
    pos = Premises(70, 120, nothing, nothing, true, nothing, true, nothing, true, "premises", false)
    @test isa(pos, Premises)

    # minSize and maxSize error (minSize must be between 60 and 1000 m²)
    @test_throws DomainError Premises(minSize=30)
    @test_throws DomainError Premises(minSize=1200)
    @test_throws DomainError Premises(maxSize=40)
    @test_throws DomainError Premises(maxSize=2000)

    # wrong location
    @test_throws DomainError Premises(location="wrong location")    

    # wrong buildingTypes
    @test_throws DomainError Premises(buildingTypes="house")

    @test_logs (:info, "bankOffer only applies in Spain") Premises(bankOffer=true)
end


@testset "Homes type" begin
   
    # empty initialization
    empty = Homes()
    @test isa(empty, Homes)

    # minSize and maxSize error (minSize must be between 60 and 1000 m²)
    @test_throws DomainError Homes(minSize=30)
    @test_throws DomainError Homes(minSize=1200)
    @test_throws DomainError Homes(maxSize=40)
    @test_throws DomainError Homes(maxSize=2000)
    
    # number of bedrooms and bathrooms must be a string of integers separated by commas
    @test_throws ArgumentError Homes(bedrooms="1,2.3,4.1")
    @test_throws ArgumentError Homes(bathrooms="1.5,2.4,5")

    # preservation must be either good or renew
    @test_throws DomainError Homes(preservation="bad")

    # furnished must be either furnished or furnishedKitchen
    @test_throws DomainError Homes(furnished="no")

    # subTypology takes independantHouse, semidetachedHouse or terracedHouse
    @test_throws DomainError Homes(subTypology="pretty house")

    @test_logs (:info, "bankOffer only applies in Spain") Homes(bankOffer=true)
end


@testset "Offices type" begin

    # empty initialization
    empty = Offices()
    @test isa(empty, Offices)

    # minSize and maxSize error (minSize must be between 60 and 1000 m²)
    @test_throws DomainError Offices(minSize=30)
    @test_throws DomainError Offices(minSize=1001)
    @test_throws DomainError Offices(maxSize=59)
    @test_throws DomainError Offices(maxSize=2000)

    # layout must be either withWalls or openPlan
    @test_throws DomainError Offices(layout="wrong layout")

    # buildingType must be exclusive or mixed
    @test_throws DomainError Offices(buildingType="mixed and exclusive")

    @test_logs (:info, "bankOffer only applies in Spain") Offices(bankOffer=true)
end


@testset "Bedrooms type" begin

    # empty initialization
    empty = Bedrooms()
    @test isa(empty, Bedrooms)

    # smokePolicy either allowed or disallowed
    @test_throws DomainError Bedrooms(smokePolicy="permitted")

    # petsPolicy either allowed or disallowed
    @test_throws DomainError Bedrooms(petsPolicy="permitted")

    # newGender either male or female
    @test_throws DomainError Bedrooms(newGender="non-binary")

end
