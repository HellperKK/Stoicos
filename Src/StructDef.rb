structMod = Hash.new($vars.unit)

structMod["update"] = NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).total_manip("struct").value
	second = look_at(array, 1).total_manip("symbol").value
	third = look_at(array, 2).get.calculate
	if first.include?(second)
		first =  first.clone
		first[second] = third
	end
	Value.new("struct", first)
end)

$vars.set_value("Struct", Value.new("struct", structMod))
