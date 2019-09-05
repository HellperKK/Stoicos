##Modif d'array
unsafeMod = Hash.new($vars.unit)

unsafeMod["set!"] = NativeFunction.new("fun", lambda do |array|
	nom = look_at(array, 0).convert("symbol").value
	value = look_at(array, 1).get.calc
	$vars.unsafe_set_value(nom, value)
	value
end)

unsafeMod["global!"] = NativeFunction.new("fun", lambda do |array|
	nom = look_at(array, 0).convert("symbol").value
	value = look_at(array, 1).get.calc
	$vars.unsafe_set_root_value(nom, value)
	value
end)

$vars.set_value("Unsafe", Value.new("struct", unsafeMod))
