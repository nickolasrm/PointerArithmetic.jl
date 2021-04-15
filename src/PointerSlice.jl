"""
    PointerSlice(arr::AbstractArray)

Returns the pointer for the argument array.
It also includes auxiliar functions for pointer load and store.

Usage
```julia
julia> a = [1,2,3,4]
julia> pt = PointerSlice(a)
julia> pt[3]
3
```
"""
PointerSlice(arr::AbstractArray) = pointer(arr)

"""
    PointerSlice(arr::AbstractArray, el_shift::Int)

Same as PointerSlice, but shifts the array in el_shift number of
elements.
"""
PointerSlice(arr::AbstractArray, el_shift::Int) =
    PointerSlice(arr) << el_shift

@inline Base.getindex(ptr::Ptr, i::Int) = unsafe_load(ptr, i)
@inline Base.setindex!(ptr::Ptr{T}, val::T, i::Int) where{T} = 
    unsafe_store!(ptr, val, i)

"""
    ptr_shift_start(ptr::Ptr, i::Int)

Shifts the pointer in the specified i number of elements.
Another way to call is to use `array << nof_elements`
Usage:
```julia_repl
julia> a = [1,2,3,4]
julia> pt = PointerSlice(a)
julia> pt[1]
1
julia> pt << 2
julia> pt[3]
3
```
"""
@inline ptr_shift_start(ptr::Ptr{T}, i::Int) where {T} = ptr + sizeof(T) * i
"""
    >>(sl::Ptr{T}, i::Int)

Same as ptr_shift_start.
"""
Base.:<<(ptr::Ptr{T}, i::Int) where {T} = ptr_shift_start(ptr, i)