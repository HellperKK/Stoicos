mathMod = Hash.new($vars.unit)

mathMod["E"] = Value.new("float", Math::E)

mathMod["PI"] = Value.new("float", Math::PI)

mathMod["sqrt"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("float").value
  Value.new("float", Math.sqrt(first))
end)

mathMod["randint"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("int").value
  second = look_at(array, 1).total_manip("int").value
  Value.new("int", rand(first..second))
end)

mathMod["randfloat"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("float").value
  second = look_at(array, 1).total_manip("float").value
  Value.new("float", rand(first..second))
end)

mathMod["bin_and"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("int").value
  second = look_at(array, 1).total_manip("int").value
  Value.new("int", first & second)
end)

mathMod["bin_or"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("int").value
  second = look_at(array, 1).total_manip("int").value
  Value.new("int", first | second)
end)

mathMod["bin_xor"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("int").value
  second = look_at(array, 1).total_manip("int").value
  Value.new("int", first ^ second)
end)

mathMod["bin_lshift"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("int").value
  second = look_at(array, 1).total_manip("int").value
  Value.new("int", first << second)
end)

mathMod["bin_rshift"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("int").value
  second = look_at(array, 1).total_manip("int").value
  Value.new("int", first >> second)
end)

mathMod["acos"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("float").value
  Value.new("float", Math.acos(first))
end)

mathMod["cos"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("float").value
  Value.new("float", Math.cos(first))
end)

mathMod["atan"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("float").value
  Value.new("float", Math.atan(first))
end)

mathMod["tan"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("float").value
  Value.new("float", Math.tan(first))
end)

mathMod["asin"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("float").value
  Value.new("float", Math.asin(first))
end)

mathMod["sin"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("float").value
  Value.new("float", Math.sin(first))
end)

$vars.set_value("Math", Value.new("struct", mathMod))
