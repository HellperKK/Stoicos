% Stoicos Manual

## Introduction

This section is an introduction about the language's story and the long path it has taken up to now. If you feel some urge to start making games you can skip directly to the next section "So you want to write a game?"

### About

The Stoicos is a simple programming language intended to beginners but still strong enough to be used by confirmed developers.
It is a functional programming language in a Lisp-like style with some imperative traits.

The project started in october 2015. It has been slowly growing since and and is at the moment transiting between the version 3 and 4.

The first version was merely a test. It served to decide some of the language's basis but wasn't easy nor pleasant to use. The second version fixed part of those problems a made the syntax more cleared. Finally, the third added more flexibility with more advanced features.

In fact, there are still some changes coming to the language which are the main reason for the development of a fourth version, as some elements have yet to be upgraded.


## So you want to write a game?

### Your first game
To start making a game, create a new directory, then download Stoicos.exe and place at its root. Then add a picture of your choice named "sprite.png" at the same place.
Then create a .txt file named `Main.txt` still in the same folder and fill it with that code :

```
=begin
Moving a sprite with arrow keys
=end

= :init (function
    {
      [32 32]
    }
  )

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

= :draw (function :state
    {
      (bind [:x :y] state)
      (Game.draw "sprite.png" x y)
    }
  )

Game.start init update draw
```

Run Stoicos.exe. You should be able to move your sprite with arrow keys.
