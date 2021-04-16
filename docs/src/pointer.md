# Pointer
Pointers are basically the same as using the Julia builtin function `pointer(array)`. Instead of adding a new structure, it only adds C like accessing, storing and shifting operations.

!!! note
    Read the PointerArithmetic page before using it

```@example pointer_main
using PointerArithmetic #hide
a = [1,2,3,4]
ptr = Pointer(a)
ptr[3]
```
Also, you can shift the starting array item:
```@example pointer_main
ptr = Pointer(a, 2)
ptr[1]
```

## Loading and Storing
As mentioned earlier, storing and loading are similar to C syntax. Just like in C, you can access unbounded elements.
```@example pointer_load_store
using PointerArithmetic #hide
a = [1,2,3,4]
ptr = Pointer(a, 2)
ptr[1]
```
```@example pointer_load_store
ptr[-1]
```
Example of load operation
```@example pointer_load_store
ptr[0] = 100
a
```
Example of store operation

!!! note
    Bounds are not problems here

## Shift
Shifting a pointer is similar to memory address manipulation. You can use the shift operator to add or subtract addresses from the base address in the pointer.

For this operation, there is one shifting 
operator:

Symbol | Description
-------|---------------------------
 `<<` | If positive, hides n elements at the beginning of the vector. Otherwise, it shows hidden elements there.

```@docs
ptr_shift_start(::Ptr, ::Int)
```