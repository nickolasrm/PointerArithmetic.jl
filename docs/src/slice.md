# Slice
Slices are easiest way to use pointers. They are basically a data structure that holds all the needed data for pointer operations. By using this, you can create `kind of a SubArray not limited by bounds`. This means that something like this is perfectly possible:

```@example slice
using PointerArithmetic #hide
a = [1,2,3,4]
slice = Slice(a, 2:3)
```

As you can see, through the use of the pointer inside of `slice` it was able to access the memory directly by its address.

!!! note
    Slices are the only subarray-like method that has bounds checking, which makes them safe.

## Loading and Storing
Since Slices are sort of a SubArray, changing a value inside of it affects the parent array.
```@example slice_load_store
using PointerArithmetic #hide
a = [1,2,3,4]
slice = Slice(a, 2:3)
slice[0]
```
Example of load operation
```@example slice_load_store
slice[0] = 100
a
```
Example of store operation

!!! note

    Remember, bounds are not problems here

## Shift
Slices are part of an array, increasing and decreasing its size is the same as moving the pointer, and the length of the array.

For this operation, there are two shifting 
operators:

Symbol | Description
-------|---------------------------
 `<<` | If positive, hides n elements at the beginning of the vector. Otherwise, it shows hidden elements there.
 `>>` | If positive, increases the length of the array, showing new elements after the current last. Otherwise, it hides the n last shown elements.

```@docs
shift_start(::Slice, ::Integer)
```

```@docs
shift_end(::Slice, ::Integer)
```