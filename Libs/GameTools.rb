######
# Classes for the lib
######
class GameToolsSprite
	attr_reader :name, :x, :y
	attr_accessor :sprite
  def self.from_image(image, x, y)
    inst = self.new(x, y)
    inst.sprite = image
		inst
  end

  def self.from_name(name, x, y)
    inst = self.new(x, y)
    inst.sprite = Gosu::Image.new(name)
		inst
  end

	def initialize(x, y)
		@x = x
		@y = y
	end
	def draw
		@sprite.draw(@x, @y, 0)
	end

  def move(x, y)
		@x += x
		@y += y
  end

  def teleport(x, y)
		@x = x
		@y = y
  end
end

class GameToolsText
	@@font = Gosu::Font.new(32)
	def initialize(x, y, text)
		@x = x
		@y = y
		@text = text
	end
	def draw
		@@font.draw_text(@text, @x, @y, 0)
	end
end

class GameToolsWindow < Gosu::Window
	def initialize
		super(640, 480, false)
		self.caption = "Project"
		@font = Gosu::Font.new(18)
		@input = []
		@sprites = []
    @showed = false
		@music = nil
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

	def add_sprite(sprite)
		@sprites << sprite
	end

	def add_text(text, x, y)
		@new_sprites << GameText.new(x, y, text)
	end

	def play_sound(name)
		begin
			sound = Gosu::Sample.new("#{$chemin.path}/#{name}")
			sound.play
		rescue

		end
	end

	def play_music(name)
		begin
			@music = Gosu::Song.new("#{$chemin.path}/#{name}")
			@music.play(true)
		rescue

		end
	end

	def stop_music
		if @music != nil
			@music.stop
		end
	end
end
######
# Create game global
######
$gametools = GameToolsWindow.new
######
# Type definitions
######
$types["sprite"] = Type.new(lambda do ||
  Value.new("sprite", GameToolsSprite.from_image(Gosu::render(1, 1, retro: true) {}, 0, 0))
end)
$types["music"] = Type.new(lambda{$vars.unit})
$types["sound"] = Type.new(lambda{$vars.unit})

######
# Main Module
######
mainMod = Hash.new($vars.unit)

mainMod["start"] = NativeFunction.new("fun", lambda do |array|
	unless $gametools.showed?
		first = look_at(array, 0).total_manip("fun")
		second = look_at(array, 1).total_manip("fun")
		thrid = look_at(array, 2).total_manip("fun")
	  $gametools.start(first, second, thrid)
	end
	$vars.unit
end)

mainMod["draw"] = NativeFunction.new("fun", lambda do |array|
	if $gametools.showed?
		first = look_at(array, 0).total_manip("sprite").value
		# second = look_at(array, 1).total_manip("int").value
		# third = look_at(array, 2).total_manip("int").value
    # first.move(second, third)
		$gametools.add_sprite(first)
	end
	$vars.unit
end)

######
# Sprite Module
######
spriteMod = Hash.new($vars.unit)

spriteMod["make"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  second = look_at(array, 1).total_manip("int").value
  third = look_at(array, 2).total_manip("int").value
  Value.new("sprite", GameToolsSprite.from_name(first, second, third))
end)

spriteMod["move"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("sprite").value
  second = look_at(array, 1).total_manip("int").value
  third = look_at(array, 2).total_manip("int").value

  first = first.clone
  first.move(second, third)

  Value.new("sprite", first)
end)

spriteMod["teleport"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("sprite").value
  second = look_at(array, 1).total_manip("int").value
  third = look_at(array, 2).total_manip("int").value

  first = first.clone
  first.teleport(second, third)

  Value.new("sprite", first)
end)

######
# Input Module
######
inputMod = Hash.new($vars.unit)

inputMod["key_code"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  case first
	when "UP" then Value.new("int", Gosu::KbUp)
  when "DOWN" then Value.new("int", Gosu::KbDown)
  when "LEFT" then Value.new("int", Gosu::KbLeft)
  when "RIGHT" then Value.new("int", Gosu::KbRight)
  when "SPACE" then Value.new("int", Gosu::KbSpace)
  else $vars.unit
  end
end)

inputMod["pressed"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("int").value
	Value.new("bool", $gametools.pressed?(first))
end)

inputMod["pressing"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("int").value
	Value.new("bool", $gametools.pressing?(first))
end)

######
# Global Module
######
globalMod = Hash.new($vars.unit)

globalMod["Main"] = Value.new("struct", mainMod)
globalMod["Sprite"] = Value.new("struct", spriteMod)
globalMod["Input"] = Value.new("struct", inputMod)

$vars.set_value("Gametools", Value.new("struct", globalMod))
