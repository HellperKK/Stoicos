VariableManager.vars.set_variable("println", NativeFunction.make(lambda do |array|
	str = array.map{|val| val.total_manip("string").value}.join(" ")
	puts str
	Value.new("string", str)
end))
