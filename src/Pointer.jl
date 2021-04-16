"""
    Pointer(arr::AbstractArray)

Returns the pointer for the argument array.
It also includes auxiliar functions for pointer load and store.

Usage
```julia-repl
julia> a = [1,2,3,4]
julia> pt = Pointer(a)
julia> pt[3]
3
```
"""
Pointer(arr::AbstractArray) = pointer(arr)

"""
    Pointer(arr::AbstractArray, el_shift::Int)

Same as Pointer, but shifts the array in el_shift number of
elements.
"""
Pointer(arr::AbstractArray, el_shift::Int) =
    Pointer(arr) << el_shift

@inline Base.getindex(ptr::Ptr, i::Int) = unsafe_load(ptr, i)
@inline Base.setindex!(ptr::Ptr{T}, val::T, i::Int) where{T} = 
    unsafe_store!(ptr, val, i)

"""
    ptr_shift_start(ptr::Ptr, i::Int)

Shifts the pointer in the specified i number of elements.
Another way to call is to use `ptr << nof_elements`
Usage:
```julia-repl
julia> a = [1,2,3,4]
julia> pt = Pointer(a)
julia> pt[1]
1
julia> pt = pt << 2
julia> pt[1]
3
```
"""
@inline ptr_shift_start(ptr::Ptr{T}, i::Int) where {T} = ptr + sizeof(T) * i
"""
    >>(sl::Ptr{T}, i::Int)

Same as ptr_shift_start.
"""
Base.:<<(ptr::Ptr{T}, i::Int) where {T} = ptr_shift_start(ptr, i)