structMod = Hash.new($vars.unit)

structMod["stop_music"] = NativeFunction.new("fun", lambda do |array|
	if $game.showed?
		$game.stop_music
	end
	$vars.unit
end)

$vars.set_value("Struct", Value.new("struct", structMod))
