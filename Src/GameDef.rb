require "gosu"
class GameSprite < Gosu::Image
	def initialize(name, x, y)
		super(name)
		@x = x
		@y = y
	end
	def draw
		super(@x, @y, 0)
	end
end
class GameWindow < Gosu::Window
	def initialize
		super(640, 480, false)
		self.caption = "Project"
		@font = Gosu::Font.new(18)
		@input = []
		# @input = InputManager.new([Gosu::KbUp, Gosu::KbDown, Gosu::KbLeft, Gosu::KbRight, Gosu::KbSpace, Gosu::MsLeft], lambda{|i| button_down?(i)})
    @sprites = []
    @showed = false
	end
	def update
		@sprites = []
		if @input.include?(Gosu::KbEscape)
			self.close!
		end
		@value = @update.call([@value])
		@draw.call([@value])
		@input = []
	end
	def draw
    @sprites.each{|i| i.draw}
	end
  def start(init, update, draw)
		@showed = true
		@value = init.call([$vars.unit])
		@update = update
		@draw = draw
		self.show
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

	# def clean_screen
	# 	@sprites = []
	# end
	def add_sprite(name, x, y)
		begin
			@sprites << GameSprite.new("#{$chemin.path}/#{name}", x, y)
		rescue

		end
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

gameMod["start"] = NativeFunction.new("fun", lambda do |array|
	unless $game.showed?
		first = look_at(array, 0).total_manip("fun")
		second = look_at(array, 1).total_manip("fun")
		thrid = look_at(array, 2).total_manip("fun")
	  $game.start(first, second, thrid)
	else
		$vars.unit
	end
end)

gameMod["pressed"] = NativeFunction.new("fun", lambda do |array|
	if $game.showed?
	  first = look_at(array, 0).total_manip("int").value
	  Value.new("bool", $game.pressed?(first))
	else
		$vars.unit
	end
end)

gameMod["pressing"] = NativeFunction.new("fun", lambda do |array|
	if $game.showed?
		first = look_at(array, 0).total_manip("int").value
	  Value.new("bool", $game.pressing?(first))
	else
		$vars.unit
	end
end)

# gameMod["clean_screen"] = NativeFunction.new("fun", lambda do |array|
# 	if $game.showed?
# 		$game.clean_screen
# 		$vars.unit
# 	else
# 		$vars.unit
# 	end
# end)

gameMod["draw"] = NativeFunction.new("fun", lambda do |array|
	if $game.showed?
		first = look_at(array, 0).total_manip("string").value
		second = look_at(array, 1).total_manip("int").value
		third = look_at(array, 2).total_manip("int").value
		$game.add_sprite(first, second, third)
		$vars.unit
	else
		$vars.unit
	end
end)

$vars.set_value("Game", Value.new("struct", gameMod))

# puts Gosu::KbUp
