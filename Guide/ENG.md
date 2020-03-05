% Stoicos Manual

# Introduction

This section is an introduction about the language's story and the long path it has taken up to now. If you feel some urge to start making games you can skip directly to the next section "So you want to write a game?"

## About

The Stoicos is a simple programming language intended to beginners but still strong enough to be used by confirmed developers.
It is a functional programming language in a Lisp-like style with some imperative traits.

The project started in october 2015. It has been slowly growing since and and is at the moment transiting between the version 3 and 4.

The first version was merely a test. It served to decide some of the language's basis but wasn't easy nor pleasant to use. The second version fixed part of those problems and made the syntax clearer. Finally, the third added more flexibility with more advanced features.

In fact, there are still some changes coming to the language which are the main reasons for the development of a fourth version, as some elements have yet to be upgraded.


## So you want to write a game?

### Your first game

To start making a game, create a new directory, then download the last release of Stoicos.exe and place at its root. Then add a picture of your choice named `sprite.png` at the same place.
Then create a .txt file named `Main.txt` still in the same folder and fill it with that code :

```
=begin
Moving a sprite with arrow keys
=end

; Generate the initial state of the game
= :init (function
    {
      [32 32]
    }
  )

; Updates the state of the game and return a new one
= :update (function :state
    {
      (bind [:new_x :new_y] state)
      (if {(Game.pressing (Game.key "UP"))}
        {(= :new_y (- new_y 1))})

      (if {(Game.pressing (Game.key "DOWN"))}
        {(= :new_y (+ new_y 1))})

      (if {(Game.pressing (Game.key "LEFT"))}
        {(= :new_x (- new_x 1))})

      (if {(Game.pressing (Game.key "RIGHT"))}
        {(= :new_x (+ new_x 1))})

      [new_x new_y]  
    }
  )

; Draws sprites depending of the state of the game
= :draw (function :state
    {
      (bind [:x :y] state)
      (Game.draw "sprite.png" x y)
    }
  )

Game.start init update draw
```

Run Stoicos.exe. You should be able to move your sprite with arrow keys.

OK. This works, but the real question is : what is happening ? To answer this we need to learn how the language works so we can abstract this code and adapt it to our own desires.

# Stoicos basics

So, learning how the Stoicos works is as easy as answering a simple yet quite deep question : How do we speak ?

## Speeches made of words

### Tokens

As in natural languages we use everyday the Stoicos' building bricks are words, but not exactly the kind of words we use traditionally, so to avoid any confusion we will call them the way they are called in the programming world which is `token`.

Tokens are like complex words that can contain any type of character (even spaces !). That feature allow them to to behave using more specialized rules. Here is a few of stoicos' tokens :

- **Integers** are made using only digit from 0 to 9 and an optionnal `-` for negation.
- **Floats** are like integers but allow a `.` to separate  decimals.
- **Booleans** are only the words `true` and `false`
- **Strings** are any characters surrounded by two `"`. You can insert special characters using a `\`
- **Symbols** are a `:` followed by a list of characters (not space authorized).
- **Arrays** are a group of symbols separated by spaces and surrounded by `[`and `]`

So for example :

- 156 and -98 are `Integers`
- 156.23 and -98.45 are `Floats`
- true and false are `Booleans`
- "Hello" and "my name is Paul" are `Strings`
- :hello and :my_name_is_Paul are `Symbols`
- [1 2 3 45] and [156 156.23 true "Hello" :hello [1 2 3 45]] are `Arrays`

### Values
I have to mention that not all token are present above. The only ones that I presented are special tokens that can also be seen as values. The difference between tokens and values is that tokens are elements that can be descripbed with letters, where values are pieces of data that are meant to be computed by the program. To simplify, some tokens represents non-value elements and some values cannot be described by a token. In both cases, we will cover them later.

## Words that build sentences

### Simple sentences

Words are usefull, but they can't have a meaning alone. It is the way thet are ordered that give that meaning. In Stoicos, each line is a sentence that is read that way : the first token is an action (we could say like a verb) and the rest is a list of parameter that are necessary for the action to perform. These token may be seen as the context in which the action is performing.

For example :

```
println "Hello world!"
+ 14 28
println (+ 14 28)
```

The firts two lines are simple to explain. The first tells "print in the console the string `Hello world!`". The second one is "Add `14` to `24`".
The last sentence is however more complex as it introduces a new token. It works like a list except the tokens it contains are encolsed in parenthesis instead of square brackets. The reason for this is that, in addition to the action a sentence performs, there is always a value that is returned. We cant then use that value in a new sentence and do that a many times as we want. So what that sentence is about is adding 14 to 28 and printing the result to the console.

In fact, parenthesis are a bit used like in mathematics, both to decribe priority and to separte child sentences from parent ones.

### Long sentences

As sentences can contain virtualy an unlimited number of subsentences, they can grow really fast. If they where limited to only on line. I would get really hard to read. For this reason, any line that starts with a space or a tabulation is considered to be part of the ine above. For example :

```
= :update (function :state
    {
      (bind [:new_x :new_y] state)
      (if {(Game.pressing (Game.key "UP"))}
        {(= :new_y (- new_y 1))})

      (if {(Game.pressing (Game.key "DOWN"))}
        {(= :new_y (+ new_y 1))})

      (if {(Game.pressing (Game.key "LEFT"))}
        {(= :new_x (- new_x 1))})

      (if {(Game.pressing (Game.key "RIGHT"))}
        {(= :new_x (+ new_x 1))})

      [new_x new_y]  
    }
  )
```

This whole chunk of text is only one sentence contaning a lot of child sentences. If it was reduced to on line, it would be very long and very hard to understand. That also tells us one thing : the way we write our code is important, so either others or even us can easiy see what it does.

### Comments

Finally, because sometimes the code itself cannont explain everything, it is possible to add comments, that is to say, elements of texts that are not read by the interpreter and are only meant for humans to read. Mainly, comments are made by adding a `;` at the begginig of the line and everything after will be treated as a comment untill there is a new line.

For example :

```
; this is a comment

; here "John" is commented
println
    "Hello"
    ; "John"
    "World"
```

You can also make block comment like this :

```
=begin
This is a block comment
This is a comment
This is too
=end
```

But this form is less recommended than the one with `;`
