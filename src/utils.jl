
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
function stringdict_to_nt(x::Dict{String, T}) where {T} 
    new_dict = Dict{Symbol, T}()

    for (key, val) in x
        setindex!(new_dict, val, Symbol(key))
    end 

    return (;new_dict...)
end


function struct_to_dict(s)
    Dict(String(key)=>getfield(s, key) for key ∈ fieldnames(typeof(s))
                if ~isnothing(getfield(s, key)))
end

