using IdealistaAPIClient: stringdict_to_nt,
                          struct_to_dict


@testset "stringdict_to_nt" begin
    d = Dict{String, String}("a"=>"b", "c"=>"d")
    nt_d = (a="b", c="d")
    @test stringdict_to_nt(d) == nt_d

    d_int = Dict("a"=>2, "b"=>3)
    nt_d_int = (a=2, b=3)
    @test stringdict_to_nt(d_int) == nt_d_int
end


@testset "struct_to_dict" begin
    struct Foo{T}
        x::T
        y::T
    end

    bar = Foo(1,2)
    @test struct_to_dict(bar) == Dict("x"=>1, "y"=>2)

end
