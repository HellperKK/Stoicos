# Stoicos
## Concept
The stoicos is a programming language interpreted in ruby.
It uses a simple lexer which makes it easier to develop.

## Specifications
The stoicos is an imperative programming language with functionnal traits, dynamic typing
and implicit conversions. Its name come from the fact that the interpreted will stay
stoic againts any type of bug and keep running at any cost.

## Use
Write your code in a .txt file and use the following command :
`ruby Stoicos.rb Path`

Path may be a .txt file or a directory, in witch case directory/Main.txt will be loaded.
With no argument given the file Main.txt from the current directory will be loaded.

You will need ruby 2.x and gosu for making games.
If you don't want to make games you may want to comment the following line in stoicos.rb :

`require_relative "Src/GameDef"`

For windows users you may also do :
`Stoicos.exe Path`

## Documentation

A wiki is avaliable in french here : [ici](https://github.com/HellperKK/Stoicos/wiki)

## How to contribute

The best way to contribute is to use the language so I can find and fix bugs or
add features on demand.
