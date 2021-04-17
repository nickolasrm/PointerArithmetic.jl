# PointerArithmetic.jl
[![codecov](https://codecov.io/gh/nickolasrm/PointerArithmetic.jl/branch/main/graph/badge.svg?token=dgE8k5nuTh)](https://codecov.io/gh/nickolasrm/PointerArithmetic.jl)
[![Build Status](https://travis-ci.com/nickolasrm/PointerArithmetic.jl.svg?branch=main)](https://travis-ci.com/nickolasrm/PointerArithmetic.jl)

This package allows you to manipulate slices and array pointers like in C. It is different than views because this package focuses on performance and at giving the programmer a way to access lower code features. 

> `WARNING!`
> Just like in C, it gives you too much power to access invalid memory positions, which may cause problems for your OS execution or application malfunctioning. Only use this library if you know exactly what you're doing.

> `WARNING!`
> When using any kind of array slices or pointers, do never lose the reference for the original array. If you lose it, the garbage collector will be able to free its memory, and the slices may cause problems or they won't be accessible anymore.

## Do I need this library?
Instead of finding the answer here, you should first ask yourself if you are planning to use C to get benefits of pointer arithmetic. If the answer is Yes, then search for some other implementations related to what you want. There are plenty of optimized codes already written. Otherwise, if you want to stay in Julia and also make use of pointers, and YOU AGREE WITH THE RISKS, then this is your lib.

## Examples
Check out some little examples to see if it is what you're looking for
### Slices example
Slices are just like views, but they allow accessing out of bounds elements without resizing
```julia
julia> a = [1,2,3,4]
julia> sl = Slice(a, 2:3)
2-Element Slice{Int64}
2
3
julia> sl[1]
2
julia> sl[0]
1
julia> sl[0] = 1000
julia> a
4-Element Vector{Int64}
1000
2
3
4
```
### Array Slice example
Array slice works like a view, but since it is a new array pointing to an interval, the memory access is direct, making it faster than views.
```julia
julia> a = [1,2,3,4]
julia> sl = ArraySlice(a, 2:3)
2-Element Vector{Int64}
2
3
julia> sl[1]
2
julia> sl[1] = 1000
julia> a
4-Element Vector{Int64}
1
1000
3
4
```
### Pointer example
Pointers are just like the C pointers. You access memory directly, and can use address arithmetic with them.
```julia
julia> a = [1,2,3,4]
julia> sl = Pointer(a)
Ptr{Int64} @0x0000000000d73fc0
julia> sl[1]
1
julia> sl[2] = 1000
julia> a
4-Element Vector{Int64}
1
1000
3
4
#Address arithmetic
julia> sl = sl << 2
julia> sl[1]
3
julia> sl[-1]
1
```

> Check out more information at its documentation: https://nickolasrm.github.io/PointerArithmetic.jl/dev
