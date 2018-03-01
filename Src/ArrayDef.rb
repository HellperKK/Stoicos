##Modif d'array
arrayMod = Hash.new($vars.unit)

arrayMod["make"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("int").value
  second = look_at(array, 1).calc.get
  Value.new("array", Array.new(first, second))
end)

arrayMod["get"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("int").value
  look_at(first, second)
end)

arrayMod["set"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("int").value
  third = look_at(array, 2).calc.get
  first[second] = third
  $vars.unit
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

arrayMod["map"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("fun")
  Value.new("array",first.map{|item| second.call([item])})
end)

arrayMod["mapi"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("fun")
  Value.new("array",first.each_with_index.map{|item, index| second.call([item, Value.new("int", index)])})
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

arrayMod["foldl"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1)
  third = look_at(array, 2).total_manip("fun")
  first.inject(second){|memo, value| third.call([memo, value])}
end)

$vars.set_value("Array", Value.new("struct", arrayMod))
