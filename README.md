# Apple's Linker Ignores Object Files In Static Libraries Consisting Entirely Of Uninitialized Variables

## Summary

Apple's linker (ld) appears to have a bug where a .o file is ignored under these conditions:

* The .o is inside a static library
* The .o only contains uninitialized variables (appears as C in nm)

References to any symbols in such an object file become undefined symbols at link time.

Neither GNU's linker nor lld appears to have this problem.

## Testing

var.c in this repository fulfills the conditions above if inside a static library.

`make test` - This will pass since var.o is linked directly.
`make test2` - This will fail, since var.o is inside libTest.a and only contains uninitialized variables.

## Workaround

You can work around this issue by initializing at least one of the variables (symbol becomes S in nm).
In the case of this repository, modify vars.c and initialize either var1 or var2 to some value.
Then the linker will find all symbols in the .o.
