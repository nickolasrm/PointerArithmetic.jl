"""
PointerArithmetic.jl

This package allows you to manipulate slices and array pointers like C.
It is different than views because this package focuses on performance 
and at giving the programmer a way to access lower code features. 
Just like C, it gives you too much power to access invalid memory positions, 
which may cause a segfault or application malfunctioning. Only use this 
library if you know exactly what you're doing.

!!!WARNING!!!
When using any kind of array slices or pointers, do never lose the reference
for the original array. If you lose it, the garbage collector will be able to
free its memory, and the slices may cause problems or they won't be accessible
anymore.
"""
module PointerArithmetic

    include("Misc.jl")

    include("PointerSlice.jl")
    export PointerSlice, ptr_shift_start

    include("UnsafeSlice.jl")
    export UnsafeSlice, unsafe_slice_shift_start, unsafe_slice_shift_end

    include("Slice.jl")
    export Slice, slice_shift_start, slice_shift_end, interval

end # module
