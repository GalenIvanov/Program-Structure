# Program-Structure
Tools for visualization of program structure, dataflow and dependancies.


### Funcs:

functions for exploring functions: arity, specification, body, dependancies.

`arity` - Returns the arity of a specific function call, including the arguments of the refinements

`extract-dummy-funcs` - Examines a block for user-defined functions. Creates a map with keys the function names and values - "dummy" function definitions with literal specification taken from the block and an empty bpdy.
