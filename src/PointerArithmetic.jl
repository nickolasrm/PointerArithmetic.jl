module PointerArithmetic

    @warn "Pointer and ArraySlice are unsafe! \n" *
          "In order to allow you working with pointer arithmetics, \n" *
          "they don't have bounds checking, and it can lead to OS \n" *
          "or application malfunctioning if used wrongly. \n" *
          "Make sure you know what you're doing before using them." maxlog = 1

    using Reexport

    include("Misc.jl")
    using .Misc

    include("Pointer.jl")
    @reexport using .Pointers

    include("ArraySlice.jl")
    @reexport using .ArraySlices

    include("Slice.jl")
    @reexport using .Slices

end
