module Slices

    using ..Pointers
    using ..ArraySlices
    using ..Misc
    export Slice, interval

    struct Slice{T} <: AbstractArray{T, 1}
        parent::AbstractArray
        pointer::Ptr{T}

        start::Int
        stop::Int

        start_bound::Int
        stop_bound::Int

        length::Int
        size::Tuple{Int}
    end

    function Slice(arr::AbstractArray, interval::UnitRange)
        assert_interval(interval)
        subarray_checkbounds(arr, interval)
        length_val = interval.stop - interval.start + 1
        Slice{eltype(arr)}(
            arr,
            Pointer(arr, interval.start - 1),
            interval.start,
            interval.stop,
            -(interval.start - 1),
            length(arr) - interval.start + 2,
            length_val,
            (length_val, )
        )
    end

    function Slice(sl::Slice, interval::UnitRange)
        parent_interval = (start(sl) + interval.start - 1):(stop(sl) + interval.stop - length(sl))
        Slice(parent(sl), parent_interval)
    end

    #Specific
    """
        shift_start(sl::Slice, i::Integer)

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
    @inline function Pointers.shift_start(sl::Slice, i::Integer)
        interval = (start(sl) + i):stop(sl)
        Slice(parent(sl), interval)
    end
    """
        <<(sl::Slice, i::Integer)

    Same as shift_start.
    """
    @inline Base.:<<(sl::Slice, i::Integer) = shift_start(sl, i)

    """
        shift_end(sl::Slice, i::Integer)

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
    @inline function ArraySlices.shift_end(sl::Slice, i::Integer)
        interval = start(sl):(stop(sl) + i)
        Slice(parent(sl), interval)
    end
    """
        >>(sl::Slice, i::Integer)

    Same as shift_end.
    """
    @inline Base.:>>(sl::Slice, i::Integer) = shift_end(sl, i)


    @inline checkbounds(::Type{Bool}, sl::Slice, i::Integer) =     
        i > start_bound(sl) && i < stop_bound(sl)

    @inline throw_bounds_error(sl::Slice, i::Integer) =
        throw(BoundsError(sl, i))

    @inline checkbounds(sl::Slice, i::Integer) = 
        checkbounds(Bool, sl, i) ||  throw_bounds_error(sl, i)

    @inline Base.getindex(sl::Slice, i::Integer) = 
        (@boundscheck checkbounds(sl, i); pointer_(sl)[i])
    @inline Base.setindex!(sl::Slice{T}, val::T, i::Integer) where{T} = 
        (@boundscheck checkbounds(sl, i); pointer_(sl)[i] = val)

    #Getters
    @inline parent(sl::Slice) = sl.parent
    @inline pointer_(sl::Slice) = sl.pointer
    @inline start(sl::Slice) = sl.start
    @inline stop(sl::Slice) = sl.stop
    @inline start_bound(sl::Slice) = sl.start_bound
    @inline stop_bound(sl::Slice) = sl.stop_bound
    @inline interval(sl::Slice) = start(sl):stop(sl)
    @inline Base.length(sl::Slice) = sl.length
    @inline Base.size(sl::Slice) = sl.size

end