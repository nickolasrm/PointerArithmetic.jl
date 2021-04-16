# PointerArithmetic
This package allows you to manipulate slices and array pointers like in C. It is different than views because this package focuses on performance and at giving the programmer a way to access lower code features. 

!!! warning

    Just like in C, it gives you too much power to access invalid memory positions, which may cause a problems to your OS execution or application malfunctioning. Only use this library if you know exactly what you're doing.

!!! warning
    When using any kind of array slices or pointers, do never lose the reference for the original array. If you lose it, the garbage collector will be able to free its memory, and the slices may cause problems or they won't be accessible anymore.

## Do I need this library?
Instead of finding the answer here, you should first ask yourself if you are planning to use C to get benefits of pointer arithmetic. If the answer is Yes, then search for some other implementations related to what you want. There are plenty of optimized codes already written. Otherwise, if you want to stay in Julia and also make use of pointers, and YOU AGREE WITH THE RISKS, then this is your lib.

## References
```@index
```