"""
    UnsafeSlice(array::AbstractArray, interval::UnitRange)

Creates a new array slice pointing to the hence array shifted by the starting 
value of the interval.
This is faster than a view, and has better performance when iterating over it.

Note: It doesn't allow you to use out of bounds indices
"""
function UnsafeSlice(arr::AbstractArray, interval::UnitRange)
    assert_interval(interval)
    unsafe_wrap(typeof(arr),
                pointer(arr) + (interval.start - 1) * sizeof(eltype(arr)),
                interval.stop - interval.start + 1,
                own = false)
end


"""
    unsafe_slice_shift_start(sl::AbstractArray, i::Int)

Shifts the array starting point in a certain number of items.
Can be called using `<<`
Usage:
```julia_repl
julia> arr = [1,2,3,4]
julia> sl = UnsafeSlice(arr, 2:3)
2-element Vector{Int64}:
2
3
julia> sl << 1
1-element Vector{Int64}:
3
julia> sl << -1
3-element Vector{Int64}:
1
2
3
```
"""
@inline unsafe_slice_shift_start(arr::AbstractArray, i::Int) =
    UnsafeSlice(arr, (1 + i):length(arr))
"""
    <<(sl::AbstractArray, i::Int)

Same as unsafe_slice_shift_start.
"""
Base.:<<(arr::AbstractArray, i::Int) = 
    unsafe_slice_shift_start(arr, i)




"""
    unsafe_slice_shift_end(sl::AbstractArray, i::Int)

Shifts the array ending point in a certain number of items.
Can be called using `>>`
Usage:
```julia_repl
julia> arr = [1,2,3,4]
julia> sl = UnsafeSlice(arr, 2:3)
2-element Vector{Int64}:
2
3
julia> sl >> 1
3-element Vector{Int64}:
2
3
4
julia> sl >> -1
1-element Vector{Int64}:
2
```
"""
@inline unsafe_slice_shift_end(arr::AbstractArray, i::Int) =
    UnsafeSlice(arr, 1:(length(arr) + i))
"""
    >>(sl::AbstractArray, i::Int)

Same as unsafe_slice_shift_end.
"""
Base.:>>(arr::AbstractArray, i::Int) =
    unsafe_slice_shift_end(arr, i)