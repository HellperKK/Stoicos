def std_init
	#Definitions des types
	$types["unit"] = Type.new()
	$types["int"] = Type.new(lambda{Value.new("int", 0)})
	$types["float"] = Type.new(lambda{Value.new("float", 0.0)})
	$types["string"] = Type.new(lambda{Value.new("string", "")})
	$types["nom"] = Type.new(lambda{Value.new("nom", "")})
	$types["bool"] = Type.new(lambda{Value.new("bool", false)})
	$types["proc"] = Type.new(lambda{Value.new("proc", [])})
	$types["block"] = Type.new(lambda{Value.new("block", [])})
	$types["fun"] = Type.new(lambda{Value.new("fun", lambda(x){$vars.get_value["unit"]})})
	
	#Definition des valeurs de base
	$vars.add("unit", Value.new("unit", nil))
	$vars.add("true", Value.new("bool", true))
	$vars.add("false", Value.new("bool", false))
	#~ $vars.add("println", Value.new("fun", lambda{|array| puts array.map{|val| val.convert("string").value}.join("")}))
	$vars.add("println", NativeFunction.new("fun", lambda{|array| puts array.map{|val| val.convert("string").value}.join(" ")}))
end