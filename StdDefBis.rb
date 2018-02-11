##Modif de string
stringMod = Hash.new($vars.unit)

stringMod["get"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  second = look_at(array, 1).total_manip("int").value
  Value.new("string", first[second])
end)

stringMod["slice"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  second = look_at(array, 1).total_manip("int").value
  third = look_at(array, 2).total_manip("int").value
  Value.new("string", first[second...third])
end)

stringMod["sub"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  second = look_at(array, 1).total_manip("int").value
  third = look_at(array, 2).total_manip("int").value
  maximum = second + third
  Value.new("string", first[second...maximum])
end)

stringMod["strip"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  Value.new("string", first.strip)
end)

stringMod["uppercase"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  Value.new("string", first.uppercase)
end)

stringMod["lowercase"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  Value.new("string", first.lowercase)
end)

stringMod["iter"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  second = look_at(array, 1).total_manip("fun")
  first.each_char{|item| second.call([Value.new("string", item)])}
  $vars.unit
end)

# A debugguer 
# stringMod["iteri"] = NativeFunction.new("fun", lambda do |array|
#   first = look_at(array, 0).total_manip("string").value
#   second = look_at(array, 1).total_manip("fun")
#   first.split("").each_with_index{|item, index| second.call([Value.new("string", item), Value.new("int", index)])}
#   $vars.unit
# end)

$vars.set_value("String", Value.new("struct", stringMod))
