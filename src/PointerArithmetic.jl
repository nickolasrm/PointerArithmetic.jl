module PointerArithmetic

    include("Misc.jl")

    include("Pointer.jl")
    export Pointer, ptr_shift_start

    include("ArraySlice.jl")
    export ArraySlice, array_slice_shift_start, array_slice_shift_end

    include("Slice.jl")
    export Slice, slice_shift_start, slice_shift_end, interval

end # module
