def std_init
	#Definitions des types
	$types["unit"] = Type.new()
	$types["int"] = Type.new(lambda{Value.new("int", 0)})
	$types["float"] = Type.new(lambda{Value.new("float", 0.0)})
	$types["string"] = Type.new(lambda{Value.new("string", "")})
	$types["nom"] = Type.new(lambda{Variable.new("nom", "unit")})
	$types["bool"] = Type.new(lambda{Value.new("bool", false)})
	$types["struct"] = Type.new(lambda{Value.new("struct", Hash.new($vars.unit))})
	$types["proc"] = Type.new(lambda{Proce.new("proc", [])})
	$types["block"] = Type.new(lambda{Blocke.new("block", [])})
	$types["fun"] = Type.new(lambda{NativeFunction.new("fun", lambda{|x|$vars.unit})})
	$types["nspace"] = Type.new(lambda{NSpace.new("nspace", "unit", "")})
	
	#Definition des convertions
	$types["int"].set_conv("string", lambda{|value| Value.new("string", value.value.to_s)})
	
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
		first = look_at(array, 0).total_manip("int").value 
		second = look_at(array, 1).total_manip("int").value 
		Value.new("int", first + second)
	end))
	$vars.set_value("-", NativeFunction.new("fun", lambda do |array|
		first = look_at(array, 0).total_manip("int").value 
		second = look_at(array, 1).total_manip("int").value 
		Value.new("int", first - second)
	end))
	$vars.set_value("*", NativeFunction.new("fun", lambda do |array|
		first = look_at(array, 0).total_manip("int").value 
		second = look_at(array, 1).total_manip("int").value 
		Value.new("int", first * second)
	end))
	$vars.set_value("/", NativeFunction.new("fun", lambda do |array|
		first = look_at(array, 0).total_manip("int").value 
		second = look_at(array, 1).total_manip("int").value 
		Value.new("int", first / second)
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
		second = look_at(array, 1).get.calc
		third = look_at(array, 2).get.calc
		if first.value
			second.calculate
		else
			third.calculate
		end
	end))
	
	#Divers
	$vars.set_value("evalb", NativeFunction.new("fun", lambda do |array|
		look_at(array, 0).total_manip("block").calculate
	end))
	
	$vars.set_value("function", NativeFunction.new("fun", lambda do |array|
		block = array.pop.total_manip("block")
		args = array.map{|value| value.calc.convert("nom")}
		CustonFunction.new("fun", block, args)
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