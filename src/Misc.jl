module Misc

    export assert_interval, subarray_checkbounds, MSG_WARN_UNSAFE

    @inline assert_interval(interval::UnitRange) = 
        @assert interval.stop >= interval.start 
                "Interval start should be lesser or equal than stop)"

    @inline checkbounds(::Type{Bool}, arr::AbstractArray, interval::UnitRange) =     
        interval.start > 0 && interval.stop <= length(arr)

    @inline throw_bounds_error(arr::AbstractArray, interval::UnitRange) =
        throw(BoundsError(arr, interval))

    @inline subarray_checkbounds(arr::AbstractArray, interval::UnitRange) = 
        checkbounds(Bool, arr, interval) || throw_bounds_error(arr, interval)
        
end