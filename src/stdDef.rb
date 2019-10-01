#Definitions des types
$types["unit"] = Type.new(lambda{$vars.unit})
$types["int"] = Type.new(lambda{Value.new("int", 0)})
$types["float"] = Type.new(lambda{Value.new("float", 0.0)})
$types["string"] = Type.new(lambda{Value.new("string", "")})
$types["stringIns"] = Type.new(lambda{Value.new("stringIns", "")})
$types["symbol"] = Type.new(lambda{Value.new("symbol", "unit")})
$types["array"] = Type.new(lambda{Value.new("array", [])})
$types["nom"] = Type.new(lambda{Variable.new("nom", "unit")})
$types["array_parse"] = Type.new(lambda{ArrayParse.new("array_parse", [])})
$types["bool"] = Type.new(lambda{Value.new("bool", true)})
$types["struct"] = Type.new(lambda{Value.new("struct", Hash.new($vars.unit))})
$types["map"] = Type.new(lambda{Value.new("struct", Hash.new($vars.unit))})
$types["proc"] = Type.new(lambda{Proce.new("proc", [])})
$types["block"] = Type.new(lambda{Blocke.new("block", [])})
$types["fun"] = Type.new(lambda{NativeFunction.new("fun", lambda{|x|$vars.unit})})

#Definition des conversions
##Unit
$types["unit"].set_conv("stringIns", lambda{|element| Value.new("stringIns", "unit")})
$types["unit"].set_conv("bool", lambda{|element| Value.new("bool", false)})

##Int
$types["int"].set_conv("float", lambda{|element| Value.new("float", element.value.to_f)})
$types["int"].set_conv("string", lambda{|element| Value.new("string", element.value.to_s)})
$types["int"].set_conv("stringIns", lambda{|element| Value.new("stringIns", element.value.to_s)})
$types["int"].set_conv("nom", lambda{|element| Variable.new("nom", element.value.to_s)})
# $types["int"].set_conv("bool", lambda{|element| Value.new("bool", element.value != 0)})

##Float
$types["float"].set_conv("int", lambda{|element| Value.new("int", element.value.to_i)})
$types["float"].set_conv("string", lambda{|element| Value.new("string", element.value.to_s)})
$types["float"].set_conv("stringIns", lambda{|element| Value.new("stringIns", element.value.to_s)})
$types["float"].set_conv("nom", lambda{|element| Variable.new("nom", element.value.to_s)})
# $types["float"].set_conv("bool", lambda{|element| Value.new("bool", element.value != 0.0)})

##Bool
$types["bool"].set_conv("string", lambda{|element| Value.new("string", element.value.to_s)})
$types["bool"].set_conv("stringIns", lambda{|element| Value.new("stringIns", element.value.to_s)})

##String
$types["string"].set_conv("int", lambda{|element| Value.new("int", element.value.to_i)})
$types["string"].set_conv("float", lambda{|element| Value.new("float", element.value.to_f)})
$types["string"].set_conv("nom", lambda{|element| Variable.new("nom", element.value)})
$types["string"].set_conv("symbol", lambda{|element| Variable.new("symbol", element.value)})
$types["string"].set_conv("stringIns", lambda{|element| Variable.new("stringIns", "\"" + element.value + "\"")})
# $types["string"].set_conv("bool", lambda{|element| Value.new("bool", element.value != "")})
$types["string"].set_conv("array", lambda{|element| Value.new("array", element.value.split("").map{|i| Value.new("string", i)})})

##Symbol
$types["symbol"].set_conv("string", lambda{|element| Value.new("string", element.value)})
$types["symbol"].set_conv("stringIns", lambda{|element| Value.new("stringIns", ":" + element.value)})
$types["symbol"].set_conv("nom", lambda{|element| Variable.new("nom", element.value)})

##Array
$types["array"].set_conv("string", lambda{|element| Value.new("string", element.value.map{|i| i.total_manip("string").value}.join("\n"))})
$types["array"].set_conv("stringIns", lambda{|element| Value.new("stringIns", "[" + element.value.map{|i| i.total_manip("stringIns").value}.join(", ") + "]")})

##Block
$types["block"].set_conv("fun", lambda{|element| CustonFunction.new("fun", element, [])})
$types["block"].set_conv("stringIns", lambda{|element| Value.new("stringIns", "A block")})

##Struct
$types["struct"].set_conv("stringIns", lambda{|element| Value.new("stringIns", "A struct")})

##Fun
$types["fun"].set_conv("stringIns", lambda{|element| Value.new("stringIns", "A function")})

##Map
$types["map"].set_conv("string", lambda{|element| Value.new("string", element.value.to_a.map{|p| p.map{|i| i.total_manip("string").value}}.to_s)})
$types["map"].set_conv("stringIns", lambda{|element| Value.new("string", element.value.to_a.map{|p| p.map{|i| i.total_manip("stringIns").value}}.to_s)})

#Definition des valeurs de base
$vars.set_value("unit", Value.new("unit", nil))
$vars.set_value("true", Value.new("bool", true))
$vars.set_value("false", Value.new("bool", false))

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
$vars.set_value("inspect", NativeFunction.new("fun", lambda do |array|
	str = array.map{|val| val.total_manip("stringIns").value}.join(" ")
	puts str
	$vars.unit
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
	nom = look_at(array, 0).convert("symbol").value
	value = look_at(array, 1).get.calc
	$vars.set_value(nom, value)
end))

$vars.set_value("assign", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).total_manip("array").value
	second = look_at(array, 1).get.calc
	first.each{|i| $vars.set_value(i.total_manip("symbol").value, second)}
	$vars.unit
end))

$vars.set_value("bind", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).total_manip("array").value.map{|i| i.total_manip("symbol").value}
	second = look_at(array, 1).total_manip("array").value.map{|i| i.get.calc}
	tab = same_size(first, second)
	first.each_with_index{|item, index| $vars.set_value(item, tab[index])}
	$vars.unit
end))

$vars.set_value("assign_fun", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).total_manip("array").value
	second = look_at(array, 1).total_manip("fun")
	first.each{|i| $vars.set_value(i.total_manip("symbol").value, second.call([]))}
	$vars.unit
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
	begin
		Value.new("int", array.map{|val| val.total_manip("int").value}.reduce(:/))
	rescue
		Value.new("int", 1)
	end
end))
$vars.set_value("%", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).total_manip("int").value
	second = look_at(array, 1).total_manip("int").value
	begin
		Value.new("int", first % second)
	rescue
		Value.new("int", 0)
	end
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

#Gestion bool
$vars.set_value("&&", NativeFunction.new("fun", lambda do |array|
	Value.new("bool", array.map{|val| val.total_manip("bool").value}.inject{|memo, value| memo && value})
end))

$vars.set_value("||", NativeFunction.new("fun", lambda do |array|
	Value.new("bool", array.map{|val| val.total_manip("bool").value}.inject{|memo, value| memo || value})
end))

$vars.set_value("!", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).total_manip("bool").value
	Value.new("bool", ! first)
end))

#Gestion comparaisons
$vars.set_value("==", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).get.calc
	second = look_at(array, 1).get.calc
	Value.new("bool", first == second)
end))
$vars.set_value("!=", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).get.calc
	second = look_at(array, 1).get.calc
	Value.new("bool", first != second)
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
		third = look_at(item, 1)
		# third = look_at(item, 1).total_manip("block")
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

$vars.set_value("times", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).total_manip("int").value
	second = look_at(array, 1).total_manip("block")
	first.times{second.calculate}
	$vars.unit
end))

#Divers
$vars.set_value("evalblock", NativeFunction.new("fun", lambda do |array|
	look_at(array, 0).total_manip("block").calculate
end))

$vars.set_value("function", NativeFunction.new("fun", lambda do |array|
	if look_at(array, 0).type == "array"
		args = look_at(array, 0).value
		block = look_at(array, 1)
	else
		args = array != [] ? array[0...-1].map{|value| value.calc.convert("symbol")} : []
		block = array != [] ? array[-1].total_manip("block") : $vars.unit
	end
	CustonFunction.new("fun", block, args)
end))

$vars.set_value("funa", NativeFunction.new("fun", lambda do |array|
	block = look_at(array, 0).total_manip("block")
	ArrayFunction.new("fun", block)
end))

$vars.set_value("|>", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).get.calculate
	second = array != [] ? array[1..-1].map {|i| i.total_manip("fun")} : []
	second.inject(first){|memo, value| value.call([memo])}
end))

$vars.set_value("convert", NativeFunction.new("fun", lambda do |array|
	first = look_at(array, 0).get.calculate
	second = look_at(array, 1).total_manip("string").value
	first.convert(second)
end))
