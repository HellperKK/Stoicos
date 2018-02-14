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

stringMod["length"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  Value.new("int", first.length)
end)

stringMod["strip"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  Value.new("string", first.strip)
end)

stringMod["split"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  second = look_at(array, 1).total_manip("string").value
  Value.new("array", first.split(second))
end)

stringMod["uppercase"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  Value.new("string", first.uppercase)
end)

stringMod["lowercase"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  Value.new("string", first.lowercase)
end)

stringMod["reverse"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  Value.new("string", first.reverse)
end)

stringMod["iter"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  second = look_at(array, 1).total_manip("fun")
  first.each_char{|item| second.call([Value.new("string", item)])}
  $vars.unit
end)


stringMod["iteri"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  second = look_at(array, 1).total_manip("fun")
  first.split("").each_with_index{|item, index| second.call([Value.new("string", item), Value.new("int", index)])}
  $vars.unit
end)

$vars.set_value("String", Value.new("struct", stringMod))

##Modif de string
arrayMod = Hash.new($vars.unit)

arrayMod["get"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("int").value
  first[second]
end)

arrayMod["slice"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("int").value
  third = look_at(array, 2).total_manip("int").value
  Value.new("array", first[second...third])
end)

arrayMod["sub"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("int").value
  third = look_at(array, 2).total_manip("int").value
  maximum = second + third
  Value.new("array", first[second...maximum])
end)

arrayMod["length"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  Value.new("int", first.length)
end)

arrayMod["reverse"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  Value.new("array", first.reverse)
end)

arrayMod["sort"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("fun")
  Value.new("array", first.sort{|x, y| second.call([x, y]).total_manip("int").value})
end)

arrayMod["iter"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("fun")
  first.each{|item| second.call([item])}
  $vars.unit
end)

arrayMod["iteri"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("fun")
  first.each_with_index{|item, index| second.call([item, Value.new("int", index)])}
  $vars.unit
end)

$vars.set_value("Array", Value.new("struct", arrayMod))
