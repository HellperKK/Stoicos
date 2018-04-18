structMod = Hash.new($vars.unit)

structMod["make"] = NativeFunction.new("fun", lambda do |array|
	block = look_at(array, 0).total_manip("block")
	$vars.add_stack
	block.calculate
	resultat = $vars.get_stack
	$vars.remove_stack
	Value.new("struct", resultat)
end)

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

structMod["update_fun"] = NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).total_manip("struct").value
	second = look_at(array, 1).total_manip("symbol").value
	third = look_at(array, 2).total_manip("fun")
	if first.include?(second)
		first =  first.clone
		first[second] = third.call([first[second]])
	end
	Value.new("struct", first)
end)

structMod["extend"] = NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).total_manip("struct").value
	second = look_at(array, 1).total_manip("symbol").value
	third = look_at(array, 2).get.calculate
	first =  first.clone
	first[second] = third
	Value.new("struct", first)
end)

$vars.set_value("Struct", Value.new("struct", structMod))
