import Base: show

"""
    stringdict_to_nt(::Dict{String, T})

Convert a Dict with String keys into a NamedTuple

# Examples

```julia
d = Dict("a"=>2, "b"=>3)

stringdict_to_nt(d)
(a=2, b=3)
```
"""
function stringdict_to_nt(x::Dict{String,T}) where {T}
    new_dict = Dict{Symbol,T}()

    for (key, val) in x
        setindex!(new_dict, val, Symbol(key))
    end

    return (; new_dict...)
end


function struct_to_dict(s)
    Dict(
        String(key) => getfield(s, key) for
        key ∈ fieldnames(typeof(s)) if ~isnothing(getfield(s, key))
    )
end


function Base.show(io::IO, s::SearchFields)
    println(io, "$(repr(typeof(s))):")
    for fname in fieldnames(typeof(s))
        println(io, "\t$fname => $(getfield(s, fname))")
    end
end


function Base.show(io::IO, r::Response)

    for fname in fieldnames(typeof(r))
        if fname != :elementList
            println(io, "\t$fname: $(getfield(r, fname))")
        end
    end

    println(io, "\n\nFound $(length(r.elementList)) properties:\n")

    for element in r.elementList
        print(io, element)
        println(io, "\n\n\n")
    end
end


function Base.show(io::IO, e::Element)
    for fname in fieldnames(typeof(e))
        if getfield(e, fname) != nothing
            println(io, "\t$fname: $(getfield(e, fname))")
        end
    end
end
