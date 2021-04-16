struct Slice{T} <: AbstractArray{T, 1}
    parent::AbstractArray
    pointer::Ptr{T}

    start::Int
    stop::Int
    length::Int
    size::Tuple{Int}
end

function Slice(arr::AbstractArray, interval::UnitRange)
    assert_interval(interval)
    length = interval.stop - interval.start + 1
    Slice{eltype(arr)}(
        arr,
        pointer(arr) + (interval.start - 1) * sizeof(eltype(arr)),
        interval.start,
        interval.stop,
        length,
        (length, )
    )
end

#Specific
"""
    slice_shift_start(sl::Slice, i::Int)

Shifts the array starting point in a certain number of items.
Can be called using `<<`
Usage:
```julia-repl
julia> arr = [1,2,3,4]
julia> sl = Slice(arr, 2:3)
2-element Slice{Int64}:
2
3
julia> sl << 1
1-element Slice{Int64}:
3
julia> sl << -1
3-element Slice{Int64}:
1
2
3
```
"""
@inline function slice_shift_start(sl::Slice, i::Int)
    new_st = start(sl) + i
    interval = new_st:stop(sl)
    assert_interval(interval)
    Slice(parent(sl), interval)
end
"""
    <<(sl::Slice, i::Int)

Same as slice_shift_start.
"""
Base.:<<(sl::Slice, i::Int) = slice_shift_start(sl, i)

"""
    slice_shift_end(sl::Slice, i::Int)

Shifts the array ending point in a certain number of items.
Can be called using `>>`
Usage:
```julia-repl
julia> arr = [1,2,3,4]
julia> sl = Slice(arr, 2:3)
2-element Slice{Int64}:
2
3
julia> sl >> 1
3-element Slice{Int64}:
2
3
4
julia> sl >> -1
1-element Slice{Int64}:
2
```
"""
@inline function slice_shift_end(sl::Slice, i::Int)
    new_st = stop(sl) + i
    interval = start(sl):new_st
    assert_interval(interval)
    Slice(parent(sl), interval)
end
"""
    >>(sl::Slice, i::Int)

Same as slice_shift_end.
"""
Base.:>>(sl::Slice, i::Int) = slice_shift_end(sl, i)

@inline Base.getindex(sl::Slice, i::Int) = pointer_(sl)[i]
@inline Base.setindex!(sl::Slice{T}, val::T, i::Int) where{T} = pointer_(sl)[i] = val

#Getters
@inline parent(sl::Slice) = sl.parent
@inline pointer_(sl::Slice) = sl.pointer
@inline start(sl::Slice) = sl.start
@inline stop(sl::Slice) = sl.stop
@inline interval(sl::Slice) = start(sl):stop(sl)
@inline Base.length(sl::Slice) = sl.length
@inline Base.size(sl::Slice) = sl.size
