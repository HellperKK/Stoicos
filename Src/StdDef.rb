#Definitions des types
$types["unit"] = Type.new()
$types["int"] = Type.new(lambda{Value.new("int", 0)})
$types["float"] = Type.new(lambda{Value.new("float", 0.0)})
$types["string"] = Type.new(lambda{Value.new("string", "")})
$types["symbole"] = Type.new(lambda{Value.new("symbole", "unit")})
$types["array"] = Type.new(lambda{Value.new("array", [])})
$types["nom"] = Type.new(lambda{Variable.new("nom", "unit")})
$types["bool"] = Type.new(lambda{Value.new("bool", false)})
$types["struct"] = Type.new(lambda{Value.new("struct", Hash.new($vars.unit))})
$types["proc"] = Type.new(lambda{Proce.new("proc", [])})
$types["block"] = Type.new(lambda{Blocke.new("block", [])})
$types["fun"] = Type.new(lambda{NativeFunction.new("fun", lambda{|x|$vars.unit})})

#Definition des convertions
##Int
$types["int"].set_conv("float", lambda{|element| Value.new("float", element.value.to_f)})
$types["int"].set_conv("string", lambda{|element| Value.new("string", element.value.to_s)})
$types["int"].set_conv("nom", lambda{|element| Variable.new("nom", element.value.to_s)})
$types["int"].set_conv("bool", lambda{|element| Value.new("bool", element.value != 0)})

##Float
$types["float"].set_conv("int", lambda{|element| Value.new("int", element.value.to_i)})
$types["float"].set_conv("string", lambda{|element| Value.new("string", element.value.to_s)})
$types["float"].set_conv("nom", lambda{|element| Variable.new("nom", element.value.to_s)})
$types["float"].set_conv("bool", lambda{|element| Value.new("bool", element.value != 0.0)})

##Bool
$types["bool"].set_conv("string", lambda{|element| Value.new("string", element.value.to_s)})

##String
$types["string"].set_conv("int", lambda{|element| Value.new("int", element.value.to_i)})
$types["string"].set_conv("float", lambda{|element| Value.new("float", element.value.to_f)})
$types["string"].set_conv("nom", lambda{|element| Variable.new("nom", element.value)})
$types["string"].set_conv("bool", lambda{|element| Value.new("bool", element.value != "")})
$types["string"].set_conv("array", lambda{|element| Value.new("array", element.value.split("").map{|i| Value.new("string", i)})})

##Array
$types["array"].set_conv("string", lambda{|element| Value.new("string", "[" + element.value.map{|i| i.total_manip("string").value}.join(", ") + "]")})

##Block
$types["block"].set_conv("fun", lambda{|element| CustonFunction.new("fun", element, [])})

#Definition des valeurs de base
#~ $vars.set_value("unit", Value.new("unit", nil))
#~ $vars.set_value("true", Value.new("bool", true))
#~ $vars.set_value("false", Value.new("bool", false))

#Definition des fonctions de base
#Gestion console
$vars.set_value("print", NativeFunction.new("fun", lambda do |array|
	str = array.map{|val| val.total_manip("string").value}.join(" ")
	print str
	Value.new("string", str)
end))

$vars.set_value("println", NativeFunction.new("fun", lambda do |array|
	str = array.map{|val| val.total_manip("string").value}.join(" ")
	puts str
	Value.new("string", str)
end))
$vars.set_value("debug", NativeFunction.new("fun", lambda do |array|
	puts array.map{|i| i.get}.to_s
end))
$vars.set_value("input", NativeFunction.new("fun", lambda do |array|
	print look_at(array, 0).total_manip("string").value
	Value.new("string", $stdin.gets.strip)
end))

#Gestion variables
$vars.set_value("=", NativeFunction.new("fun", lambda do |array|
	nom = look_at(array, 0).convert("nom").value
	value = look_at(array, 1).get.calc
	$vars.set_value(nom, value)
	value
end))

#Gestion entiers
$vars.set_value("+", NativeFunction.new("fun", lambda do |array|
	Value.new("int", array.map{|val| val.total_manip("int").value}.reduce(:+))
end))
$vars.set_value("-", NativeFunction.new("fun", lambda do |array|
	Value.new("int", array.map{|val| val.total_manip("int").value}.reduce(:-))
end))
$vars.set_value("*", NativeFunction.new("fun", lambda do |array|
	Value.new("int", array.map{|val| val.total_manip("int").value}.reduce(:*))
end))
$vars.set_value("/", NativeFunction.new("fun", lambda do |array|
	Value.new("int", array.map{|val| val.total_manip("int").value}.reduce(:/))
end))
$vars.set_value("%", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).total_manip("int").value
	second = look_at(array, 1).total_manip("int").value
	Value.new("int", first % second)
end))

#Gestion flottants
$vars.set_value("+.", NativeFunction.new("fun", lambda do |array|
	Value.new("float", array.map{|val| val.total_manip("float").value}.reduce(:+))
end))
$vars.set_value("-.", NativeFunction.new("fun", lambda do |array|
	Value.new("float", array.map{|val| val.total_manip("float").value}.reduce(:-))
end))
$vars.set_value("*.", NativeFunction.new("fun", lambda do |array|
	Value.new("float", array.map{|val| val.total_manip("float").value}.reduce(:*))
end))
$vars.set_value("/.", NativeFunction.new("fun", lambda do |array|
	Value.new("float", array.map{|val| val.total_manip("float").value}.reduce(:/))
end))
$vars.set_value("**", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).total_manip("float").value
	second = look_at(array, 1).total_manip("float").value
	Value.new("float", first ** second)
end))

#Gestion strings
$vars.set_value("^", NativeFunction.new("fun", lambda do |array|
	Value.new("string", array.map{|val| val.total_manip("string").value}.join(""))
end))

#Gestion bool
$vars.set_value("&&", NativeFunction.new("fun", lambda do |array|
	Value.new("bool", array.map{|val| val.total_manip("bool").value}.inject{|memo, value| memo && value})
end))

$vars.set_value("||", NativeFunction.new("fun", lambda do |array|
	Value.new("bool", array.map{|val| val.total_manip("bool").value}.inject{|memo, value| memo || value})
end))

#Gestion comparaisons
$vars.set_value("==", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).get.calc
	second = look_at(array, 1).get.calc
	Value.new("bool", (first.type == second.type) && (first.value == second.value))
end))
$vars.set_value("!=", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).get.calc
	second = look_at(array, 1).get.calc
	Value.new("bool", (first.type != second.type) && (first.value != second.value))
end))
$vars.set_value("<", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).get.calc
	second = look_at(array, 1).get.calc
	Value.new("bool", (first.type < second.type) || ((first.type == second.type) && (first.value < second.value)))
end))
$vars.set_value("<=", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).get.calc
	second = look_at(array, 1).get.calc
	Value.new("bool", (first.type < second.type) || ((first.type == second.type) && (first.value <= second.value)))
end))
$vars.set_value(">", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).get.calc
	second = look_at(array, 1).get.calc
	Value.new("bool", (first.type > second.type) || ((first.type == second.type) && (first.value > second.value)))
end))
$vars.set_value(">=", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).get.calc
	second = look_at(array, 1).get.calc
	Value.new("bool", (first.type > second.type) || ((first.type == second.type) && (first.value >= second.value)))
end))
$vars.set_value("<=>", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).get.calc
	second = look_at(array, 1).get.calc
	if (first.type == second.type) && (first.value == second.value)
		Value.new("int", 0)
	elsif (first.type > second.type) || ((first.type == second.type) && (first.value > second.value))
		Value.new("int", 1)
	else
		Value.new("int", -1)
	end
end))

#Gestion block
$vars.set_value("cond", NativeFunction.new("fun", lambda do |array|
	first = array.map{|i| i.total_manip("array").value}
	first.each do |item|
		second = look_at(item, 0).get.calculate.convert("bool").value
		third = look_at(item, 1).total_manip("block")
		if second
			return third.calculate
		end
	end
	$vars.unit
end))

$vars.set_value("if", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).get.calculate.convert("bool").value
	second = look_at(array, 1).total_manip("block")
	third = look_at(array, 2).total_manip("block")
	if first
		second.calculate
	else
		third.calculate
	end
end))

#Divers
$vars.set_value("evalblock", NativeFunction.new("fun", lambda do |array|
	look_at(array, 0).total_manip("block").calculate
end))

$vars.set_value("function", NativeFunction.new("fun", lambda do |array|
	args = array != [] ? array[0...-1].map{|value| value.calc.convert("nom")} : $vars.unit
	block = array != [] ? array[-1].total_manip("block") : $vars.unit
	CustonFunction.new("fun", block, args)
end))

$vars.set_value("funa", NativeFunction.new("fun", lambda do |array|
	block = look_at(array, 0).total_manip("block")
	ArrayFunction.new("fun", block)
end))

$vars.set_value("|>", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).get.calculate
	second = array != [] ? array[1..-1].map {|i| i.total_manip("fun")} : $vars.unit
	second.inject(first){|memo, value| value.call([memo])}
end))

$vars.set_value("struct", NativeFunction.new("fun", lambda do |array|
	block = look_at(array, 0).total_manip("block")
	$vars.add_stack
	block.calculate
	resultat = $vars.get_stack
	$vars.remove_stack
	Value.new("struct", resultat)
end))
