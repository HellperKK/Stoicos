require "gosu"
class GameWindow < Gosu::Window
	def initialize
		super(640, 480, false)
		self.caption = "JeuCartesVerehn"
		@font = Gosu::Font.new(18)
		# @input = InputManager.new([Gosu::KbUp, Gosu::KbDown, Gosu::KbLeft, Gosu::KbRight, Gosu::KbSpace, Gosu::MsLeft], lambda{|i| button_down?(i)})
    @sprites = []
	end
	def button_down(id)
		@input.addPress(id)
	end
	def update
		@input = []
	end
	def draw
    @sprites.each{|i| i.draw}
	end
end

##Modif de jeu
gameMod = Hash.new($vars.unit)

gameMod["get"] = NativeFunction.new("fun", lambda do |array|
  $vars.set_value("String", Value.new("struct", stringMod))
end)
