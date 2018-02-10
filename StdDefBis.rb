stringMod = Hash.new(Value.new("unit", nil))

stringMod["get"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("int").value
  second = look_at(array, 1).total_manip("string").value
  Value.new("string", second[first])
end)

stringMod["set"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("int").value
  second = look_at(array, 1).total_manip("string").value
  third = look_at(array, 2).total_manip("string").value
  second[first] = third
  Value.new("string", second)
end)

$vars.set_value("String", Value.new("struct", stringMod))
