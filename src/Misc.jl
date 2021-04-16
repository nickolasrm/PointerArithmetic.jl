@inline assert_interval(interval::UnitRange) = 
    @assert interval.stop >= interval.start 
            "Interval start should be lesser or equal than stop)"