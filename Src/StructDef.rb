structMod = Hash.new($vars.unit)


structMod["empty"] = Value.new("struct", Hash.new())

structMod["build"] = NativeFunction.new("fun", lambda do |array|
	symbols = array.map{|val| val.total_manip("symbol").value}
	resultat = Hash.new($vars.unit)
	resultat["make"] = NativeFunction.new("fun", lambda do |arraybis|
		first = Hash.new($vars.unit)
		symbols.each_with_index{|item, index| first[item] = look_at(arraybis, index)}
		Value.new("struct", first)
	end)
	resultat["is"] = NativeFunction.new("fun", lambda do |arraybis|
		first = look_at(arraybis, 0).total_manip("struct").value.keys
		second = symbols.all?{|sym| first.include?(sym)}
		Value.new("bool", second)
	end)
	resultat["extends"] = NativeFunction.new("fun", lambda do |arraybis|
		first = look_at(arraybis, 0).total_manip("struct").value.clone
		second = look_at(arraybis, 1).get.calc
		symbols.each do |i|
			first[i] = second unless first.include?(i)
		end
		Value.new("struct", first)
	end)
	Value.new("struct", resultat)
end)

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

structMod["extend_fun"] = NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).total_manip("struct").value
	second = look_at(array, 1).total_manip("symbol").value
	third = look_at(array, 2).total_manip("fun")
	first =  first.clone
	first[second] = third.call([first[second]])
	Value.new("struct", first)
end)

structMod["concat"] = NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).total_manip("struct").value
	second = look_at(array, 1).total_manip("struct").value
	Value.new("struct", first.merge(second))
end)

structMod["iter"] = NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).total_manip("struct").value
	second = look_at(array, 1).total_manip("fun")
	first.each{|index, item| second.call([item, Value.new("symbol", index)])}
	$vars.unit
end)

$vars.set_value("Struct", Value.new("struct", structMod))
