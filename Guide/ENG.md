% Stoicos Manual

# Introduction

This section is an introduction about the language's story and the long path it has taken up to now. If you feel some urge to start making games you can skip directly to the next section "So you want to write a game?"

## About

The Stoicos is a simple programming language intended to beginners but still strong enough to be used by confirmed developers.
It is a functional programming language in a Lisp-like style with some imperative traits.

The project started in october 2015. It has been slowly growing since and and is at the moment transiting between the version 3 and 4.

The first version was merely a test. It served to decide some of the language's basis but wasn't easy nor pleasant to use. The second version fixed part of those problems a made the syntax more cleared. Finally, the third added more flexibility with more advanced features.

In fact, there are still some changes coming to the language which are the main reason for the development of a fourth version, as some elements have yet to be upgraded.


## So you want to write a game?

### Your first game
To start making a game, create a new directory, then download Stoicos.exe and place at its root. Then add a picture of your choice named `sprite.png` at the same place.
Then create a .txt file named `Main.txt` still in the same folder and fill it with that code :

```
=begin
Moving a sprite with arrow keys
=end

#Generate the initial state of the game
= :init (function
    {
      [32 32]
    }
  )

#Updates the state of the game and return a new one
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

#Draws sprites depending of the state of the game
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

As in natural language we use everyday the Stoicos' building bricks are words, but not exactly the kind of words we use traditionally, so to avoid any confusion we will call them the way they are called in the programming world which is `token`.

Tokens are like complex words that can contain any type of character (even spaces !). That feature allow them to to behave using more specialized rules. Here is a few of stoicos' tokens :

- **Integers** are made using only digit from 0 to 9 and an optionnal `-` for negation.
- **Floats** are like integers but allowing a `.` to separate  decimals.
- **Booleans** are only the words `true` and `false`
- **Strings** are any characters surrounded by two `"`.
- **Symbols** are a `:` followed by a list of characters (not space authorized).
- **Arrays** are a group of others symbols separated by spaces and surrounded by `[`and `]`

So for example :

- 156 and -98 are `Integers`
- 156.23 and -98.45 are `Floats`
- true and false are `Booleans`
- "Hello" and "my name is Paul" are `Strings`
- :hello and :my_name_is_Paul are `Symbols`
- [1 2 3 45] and [156 156.23 true "Hello" :hello [1 2 3 45]] are `Arrays`

## Words that build sentences
