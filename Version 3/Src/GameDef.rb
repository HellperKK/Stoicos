require "gosu"
# class GameSprite < Gosu::Image
# 	def initialize(name, x, y)
# 		super(name)
# 		@x = x
# 		@y = y
# 	end
# 	def draw
# 		super(@x, @y, 0)
# 	end
# end
class GameSprite
	@@sprites = Hash.new
	attr_reader :name, :x, :y
	def initialize(name, x, y)
		@name = name
		@x = x
		@y = y
		manageSprite
	end
	def draw
		@@sprites[@name].draw(@x, @y, 0)
	end
	def manageSprite
		unless @@sprites.include?(@name)
			@@sprites[@name] = Gosu::Image.new(@name)
		end
	end
end
class GameText
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
class GameWindow < Gosu::Window
	def initialize
		super(640, 480, false)
		self.caption = "Project"
		@font = Gosu::Font.new(18)
		@input = []
		# @input = InputManager.new([Gosu::KbUp, Gosu::KbDown, Gosu::KbLeft, Gosu::KbRight, Gosu::KbSpace, Gosu::MsLeft], lambda{|i| button_down?(i)})
    @sprites = []
		@new_sprites = []
    @showed = false
		@music = nil
	end
	def update
		@new_sprites = []
		if @input.include?(Gosu::KbEscape)
			self.close!
		end
		@value = @update.call([@value])
		@draw.call([@value])
		@input = []
		@sprites = @new_sprites
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

	# def add_sprite(name, x, y)
	# 	begin
	# 		@sprites << GameSprite.new("#{$chemin.path}/#{name}", x, y)
	# 	rescue
	#
	# 	end
	# end

	def add_sprite(name, x, y)
		begin
			pred = nil
			pred = @sprites.find_index{|spr| (spr.x == x) && (spr.y == y) && (spr.name == $chemin.relative(name))}
			if pred != nil
				#puts "Valid"
				@new_sprites << @sprites[pred]
				@pred.delete_at(pred)
			else
				#puts "InValid"
				@new_sprites << GameSprite.new("#{$chemin.path}/#{name}", x, y)
			end
		rescue
			#puts e
		end
	end

	def add_text(text, x, y)
		@new_sprites << GameText.new(x, y, text)
	end

	def play_sound(name)
		puts "test"
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

gameMod["draw"] = NativeFunction.new("fun", lambda do |array|
	if $game.showed?
		first = look_at(array, 0).total_manip("string").value
		second = look_at(array, 1).total_manip("int").value
		third = look_at(array, 2).total_manip("int").value
		if File.exist?(first)
			$game.add_sprite(first, second, third)
		else
			raise "I'm trying tro draw a file that don't exist : #{first}"
		end
	end
	$vars.unit
end)

gameMod["draw_text"] = NativeFunction.new("fun", lambda do |array|
	if $game.showed?
		first = look_at(array, 0).total_manip("string").value
		second = look_at(array, 1).total_manip("int").value
		third = look_at(array, 2).total_manip("int").value
		$game.add_text(first, second, third)
	end
	$vars.unit
end)

gameMod["play_sound"] = NativeFunction.new("fun", lambda do |array|
	if $game.showed?
		first = look_at(array, 0).total_manip("string").value
		$game.play_sound(first)
	end
	$vars.unit
end)

gameMod["play_music"] = NativeFunction.new("fun", lambda do |array|
	if $game.showed?
		first = look_at(array, 0).total_manip("string").value
		$game.play_music(first)
	end
	$vars.unit
end)

gameMod["stop_music"] = NativeFunction.new("fun", lambda do |array|
	if $game.showed?
		$game.stop_music
	end
	$vars.unit
end)

$vars.set_value("Game", Value.new("struct", gameMod))

# puts Gosu::KbUp
