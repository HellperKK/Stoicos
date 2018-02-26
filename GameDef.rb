require "gosu"
class GameWindow < Gosu::Window
	def initialize
		super(640, 480, false)
		self.caption = "JeuCartesVerehn"
		@font = Gosu::Font.new(18)
		# @input = InputManager.new([Gosu::KbUp, Gosu::KbDown, Gosu::KbLeft, Gosu::KbRight, Gosu::KbSpace, Gosu::MsLeft], lambda{|i| button_down?(i)})
    @sprites = []
    @showed = false
	end
	def update
		@input = []
	end
	def draw
    @sprites.each{|i| i.draw}
	end
  def show
    @showed = true
    super
  end

  def button_down(id)
		@input << id
	end
  def pressed?(id)
    @input.include?(id)
  end
  def pressing?(id)
    button_down?(id)
  end

  def showed?
    @showed
  end
end

$game = GameWindow.new

##Modif de jeu
gameMod = Hash.new($vars.unit)

gameMod["key"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  case first
  when "UP" then Value.new("int", Gosu::KbUp)
  when "DOWN" then Value.new("int", Gosu::KbDown)
  when "LEFT" then Value.new("int", Gosu::KbLeft)
  when "RIGHT" then Value.new("int", Gosu::KbRight)
  when "SPACE" then Value.new("int", Gosu::KbSpace)
  else Value.new("int", Gosu::KbSpace)
  end
end)

$vars.set_value("Game", Value.new("struct", gameMod))

# puts Gosu::KbUp
