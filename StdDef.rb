def std_init
	#Definitions des types
	$types["unit"] = Type.new()
	$types["int"] = Type.new(lambda{|element| Value.new("int", 0)})
	$types["float"] = Type.new(lambda{|element| Value.new("float", 0.0)})
	$types["string"] = Type.new(lambda{|element| Value.new("string", "")})
	$types["array"] = Type.new(lambda{|element| Value.new("array", [element])})
	$types["nom"] = Type.new(lambda{|element| Variable.new("nom", "unit")})
	$types["bool"] = Type.new(lambda{|element| Value.new("bool", false)})
	$types["struct"] = Type.new(lambda{|element| Value.new("struct", Hash.new($vars.unit))})
	$types["proc"] = Type.new(lambda{|element| Proce.new("proc", [])})
	$types["block"] = Type.new(lambda{|element| Blocke.new("block", [])})
	$types["fun"] = Type.new(lambda{|element| NativeFunction.new("fun", lambda{|x|$vars.unit})})
	$types["funa"] = Type.new(lambda{|element| ArrayFunction.new("funa", lambda{|x|$vars.unit})})
	$types["nspace"] = Type.new(lambda{|element| NSpace.new("nspace", "unit", "")})

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

	##String
	$types["string"].set_conv("int", lambda{|element| Value.new("int", element.value.to_i)})
	$types["string"].set_conv("float", lambda{|element| Value.new("float", element.value.to_f)})
	$types["string"].set_conv("nom", lambda{|element| Variable.new("nom", element.value)})
	$types["string"].set_conv("bool", lambda{|element| Value.new("bool", element.value != "")})

	##Fun
	$types["fun"].set_conv("block", lambda{|element| element.value})

	##Funa
	$types["funa"].set_conv("block", lambda{|element| element.value})

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
		#~ puts array.to_ss
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

	#~ $vars.set_value("/", NativeFunction.new("fun", lambda do |array|
		#~ first = look_at(array, 0).total_manip("int").value
		#~ second = look_at(array, 1).total_manip("int").value
		#~ Value.new("int", first / second)
	#~ end))

	#Gestion strings
	$vars.set_value("^", NativeFunction.new("fun", lambda do |array|
		Value.new("string", array.map{|val| val.total_manip("string").value}.join(""))
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
		Value.new("bool", (first.type <= second.type) || ((first.type == second.type) && (first.value <= second.value)))
	end))
	$vars.set_value(">", NativeFunction.new("fun", lambda do |array|
		first = look_at(array, 0).get.calc
		second = look_at(array, 1).get.calc
		Value.new("bool", (first.type > second.type) || ((first.type == second.type) && (first.value > second.value)))
	end))
	$vars.set_value(">=", NativeFunction.new("fun", lambda do |array|
		first = look_at(array, 0).get.calc
		second = look_at(array, 1).get.calc
		Value.new("bool", (first.type <= second.type) || ((first.type == second.type) && (first.value >= second.value)))
	end))

	#Gestion block
	$vars.set_value("if", NativeFunction.new("fun", lambda do |array|
		first = look_at(array, 0).total_manip("bool")
		second = look_at(array, 1).total_manip("block")
		third = look_at(array, 2).total_manip("block")
		if first.value
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
		block = array.pop.total_manip("block")
		args = array.map{|value| value.calc.convert("nom")}
		CustonFunction.new("fun", block, args)
	end))

	$vars.set_value("funa", NativeFunction.new("fun", lambda do |array|
		block = look_at(array, 0).total_manip("block")
		ArrayFunction.new("funa", block)
	end))

	$vars.set_value("struct", NativeFunction.new("fun", lambda do |array|
		block = look_at(array, 0).total_manip("block")
		$vars.add_stack
		block.calculate
		resultat = $vars.get_stack
		$vars.remove_stack
		Value.new("struct", resultat)
	end))
end
