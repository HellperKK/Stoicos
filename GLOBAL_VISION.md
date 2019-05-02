# Global vision of the stoicos language
## About
Here I will try to describe how I'd like to make the language evolve. Since I'm starting to develop things that I do not totally master with my current knowledge, it may be good (to be honest it's quite a must) to have some advices on what I'm doing.

## Tokens
### Definition
First, everything in the language is a token since le language passes through a lexer but no parser.
It was at first a way to make the language easy to develop and has been kept so that any word in the language has the same meaning no matter where it has been written.

For example `FOO` will always be a variable (actually it will refer only to its content) and `:FOO` will always be a symbol.
I think that keeping the same meaning makes it clearer to reason about since you don't have to know the context to understand what is happening.
For this reason, assigning a value to a variable may be `= :foo bar` and not `= foo bar`

### List of Tokens
Here's the list :

#### Number
Represent any number. So both integers and floats count.
In version 3 they were separated but this led to having each numeric operator duplicated for each type, which is not compatible with the idea of making it beginner friendly.

#### String
Simple representation of strings.

#### Booleans
Simple representation of booleans.

#### Symbol
Like a string but is mainly used to reference a name, like a variable.

#### Array
Simple representation of arrays.

#### ArrayParse
Created at lex time when using the [] syntax, it exist so the real array it made only at runtime.

#### Unit
Special value that represent nothing

#### Identifier
Value meant to represent the content of a variable

#### Proce
Value that represent a function call. Meant to be automatically called when used.

#### Block
Values that holds a list a values to be evaluated (like in conditionals or functions). Will return the last evaluated value when so.

#### NativeFunction
Mostly for the functions defined in the standard library.

#### CustomFunction
For functions created by the user with a fixed number of arguments.

#### ArrayFunction
Like CustomFunction but ha only on argument which is a array of every arguments passed to the function.

#### Struct
Value that holds a hash of string as keys and tokens as values. Used a lot for modules.

#### Nspace
Token like Identifier that refers to an attribute of a struc in a variable using the syntax `Var.attribute`.

#### Map
Simple representation of hash.
