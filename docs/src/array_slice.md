
# ArraySlice
ArraySlices are another way to use pointers. Instead of accessing addresses directly, they create another Array pointing to the address at the specified interval of the parent array.

!!! note
    Read the first page before using it

```@example array_slice
using PointerArithmetic #hide
a = [1,2,3,4]
slice = ArraySlice(a, 2:3)
```

## Loading and Storing
Since it makes a new array, bounds checking are mandatory. Thus, accessing out of range elements will result in an error.

### Performance
Because of the array creation, it doesn't need to access a structure to reach the pointer, but the memory already. It makes the `ArraySlice to be faster than Slice and faster than a View, which is good for iterating over it`.

## Shift
Shifting works just like with Slices, and it can be a way out for the problem of accessing elements out of bounds.

Symbol | Description
-------|---------------------------
 `<<` | If positive, hides n elements at the beginning of the vector. Otherwise, it shows hidden elements there.
 `>>` | If positive, increases the length of the array, showing new elements after the current last. Otherwise, it hides the n last shown elements.

```@docs
array_slice_shift_start(::Slice, ::Int)
```

```@docs
array_slice_shift_end(::Slice, ::Int)
```