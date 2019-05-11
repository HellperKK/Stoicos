# Global vision of the stoicos language
## About

Here I will try to describe how I'd like to make the language evolve. Since I'm starting to develop things that I do not totally master with my current knowledge, it may be good (to be honest it's quite a must) to have some advices on what I'm doing.

## Tokens
### Definition

First, everything in the language is a token since le language passes through a lexer but no parser.
It was at first a way to make the language easy to develop and has been kept so that any word in the language has the same meaning no matter where it has been written.

For example `FOO` will always be a variable (actually it will refer only to its content) and `:FOO` will always be a symbol.
I think that keeping the same meaning makes it clearer to reason about since you don't have to know the context to understand what is happening.
For this reason, assigning a value to a variable is `= :foo bar` and not `= foo bar`

### List of Tokens

Here's the list :

**Number** :
Represent any number. So both integers and floats count.
In version 3 they were separated but this led to having each numeric operator duplicated for each type, which is not compatible with the idea of making it beginner friendly.

**String** :
Simple representation of strings.

**Booleans** :
Simple representation of booleans.

**Symbol** :
Like a string but is mainly used to reference a name, like a variable.

**Array** :
Simple representation of arrays.

**ArrayParse** :
Created at lex time when using the [] syntax, it exist so the real array it made only at runtime.

**Unit** :
Special value that represent nothing

**Identifier** :
Value meant to represent the content of a variable

**Proce** :
Value that represent a function call. Meant to be automatically called when used.

**Block** :
Values that holds a list a values to be evaluated (like in conditionals or functions). Will return the last evaluated value when so.

**NativeFunction** :
Mostly for the functions defined in the standard library.

**CustomFunction** :
For functions created by the user with a fixed number of arguments.

**ArrayFunction** :
Like CustomFunction but ha only on argument which is a array of every arguments passed to the function.

**Struct** :
Value that holds a hash of string as keys and tokens as values. Used a lot for modules.

**Nspace** :
Token like Identifier that refers to an attribute of a struc in a variable using the syntax `Var.attribute`.

**Map** :
Simple representation of hash.

## Variables

For the moment variable are stored in an array of hashes of type (String, Token). Each Hash represents a stack ans a new hash is added at the end of the array when a CustomFunction or an ArrayFunction is called. The look-up algorithm that search for a variable will go through the array in reverse until a stack containing the variable is found and return the corresponding value.

Variable of a parent stack can then be used but not modified. when putting a value into a variable it will only modify the current stack, creating a variable if needed.

A variables can be constant so that assigning it a value will only throw an exception. It can also be assigned a type.

Looking defining variables dynamically is nice but can lead to some weird bugs in some cases. The version 3 adds a `@` prefixed token that is replaced by its value at lex time but it is a very specific fix that does not work all time.

## Type system
### Type definition
In Stoicos types describes tokens that are used as values inside a program. So a Number is a type but an Identifier is not. This means that not all tokens are values and not all values are tokens since they are constructed from functions instead of a textual representation.

I'd like to make types as a special struct type. This means that each type data is stored in a module and since structs can be extended the module can also have any number of values and functions to manipulate the type. The type `type` would then force to have some struct fields to make sure a type is valid.

### Implicit conversion
One of the key elements of the language is its implicit conversions. It may sound weird to some people but this was at first made to simplify the development and has been kept since. But unlike languages like javascript the idea is to give to the user the power to choose how these conversions are working together between both primitives and user-defined types.
