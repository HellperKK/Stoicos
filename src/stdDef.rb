VariableManager.vars.set_variable("unit", Value.new("unit", nil))

VariableManager.vars.set_variable("println", NativeFunction.make(lambda do |array|
	str = array.map{|val| val.total_manip("string").value}.join(" ")
	puts str
	Value.new("string", str)
end))

VariableManager.vars.set_variable("print", NativeFunction.make(lambda do |array|
	str = array.map{|val| val.value}.join(" ")
	print str
	Value.new("string", str)
end))

VariableManager.vars.set_variable("def", NativeFunction.make(lambda do |array|
	var_name = look_at(array, 0).value
	value = look_at(array, 1)
	VariableManager.vars.set_variable(var_name, value)
	value
end))
