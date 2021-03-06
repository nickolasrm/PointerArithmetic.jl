module ArraySlices

    using ..Misc
    using ..Pointers

    export ArraySlice, shift_end

    """
        ArraySlice(array::AbstractArray, interval::UnitRange)

    Creates a new array slice pointing to the hence array shifted by the starting 
    value of the interval.
    This is faster than a view, and has better performance when iterating over it.

    Note: It doesn't allow you to use out of bounds indices
    """
    function ArraySlice(arr::AbstractArray, interval::UnitRange)
        assert_interval(interval)
        unsafe_wrap(typeof(arr),
                    Pointer(arr, interval.start - 1),
                    interval.stop - interval.start + 1,
                    own = false)
    end


    """
        shift_start(sl::AbstractArray, i::Integer)

    Shifts the array starting point in a certain number of items.
    Can be called using `<<`
    Usage:
    ```julia-repl
    julia> arr = [1,2,3,4]
    julia> sl = ArraySlice(arr, 2:3)
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
    @inline Pointers.shift_start(arr::AbstractArray, i::Integer) =
        ArraySlice(arr, (1 + i):length(arr))
    """
        <<(sl::AbstractArray, i::Integer)

    Same as shift_start.
    """
    Base.:<<(arr::AbstractArray, i::Integer) = 
        shift_start(arr, i)




    """
        shift_end(sl::AbstractArray, i::Integer)

    Shifts the array ending point in a certain number of items.
    Can be called using `>>`
    Usage:
    ```julia-repl
    julia> arr = [1,2,3,4]
    julia> sl = ArraySlice(arr, 2:3)
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
    @inline shift_end(arr::AbstractArray, i::Integer) =
        ArraySlice(arr, 1:(length(arr) + i))
    """
        >>(sl::AbstractArray, i::Integer)

    Same as array_slice_shift_end.
    """
    Base.:>>(arr::AbstractArray, i::Integer) =
        shift_end(arr, i)

end