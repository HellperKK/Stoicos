##Modif d'array
arrayMod = Hash.new($vars.unit)

arrayMod["make"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("int").value
  second = look_at(array, 1).calc.get
  Value.new("array", Array.new(first, second))
end)

arrayMod["make_fun"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("int").value
  second = look_at(array, 1).total_manip("fun")
  Value.new("array", Array.new(first, second.call([])))
end)

arrayMod["make_range"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("int").value
  second = look_at(array, 1).total_manip("int").value
  Value.new("array", (first...second).map {|i| Value.new("int", i)})
end)

arrayMod["concat"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("array").value
  Value.new("array", first + second)
end)

arrayMod["get"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("int").value
  look_at(first, second)
end)

arrayMod["first"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  look_at(first, 0)
end)

arrayMod["rest"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  if first == []
    Value.new("array", [])
  else
    Value.new("array", first[1..-1])
  end
end)

arrayMod["set"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("int").value
  third = look_at(array, 2).calc.get
  first = first.clone
  first[second] = third
  first = first.map{|e| e == nil ? $vars.unit : e}
  Value.new("array", first)
end)

arrayMod["set_fun"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("int").value
  third = look_at(array, 2).total_manip("fun")
  first = first.clone
  before = look_at(first, second)
  first[second] = third.call([before])
  first = first.map{|e| e == nil ? $vars.unit : e}
  Value.new("array", first)
end)

arrayMod["push"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).calc.get
  first = first.clone
  first << second
  Value.new("array", first)
end)

arrayMod["pop"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  first = first.clone
  first.pop
  Value.new("array", first)
end)

arrayMod["unshift"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).calc.get
  first = first.clone
  first.unshift(second)
  Value.new("array", first)
end)

arrayMod["shift"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  first = first.clone
  first.shift
  Value.new("array", first)
end)

arrayMod["delete_at"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("int").value
  first = first.clone
  first.delete_at(second)
  Value.new("array", first)
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

arrayMod["join"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("string").value
  Value.new("string", first.join(second))
end)

arrayMod["concat"] = NativeFunction.new("fun", lambda do |array|
	first = array.map{|val| val.total_manip("array").value}
	Value.new("array", first.inject{|memo, value| memo + value})
end)

arrayMod["reverse"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  Value.new("array", first.reverse)
end)

arrayMod["filter"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("fun")
  Value.new("array",first.select{|item| second.call([item]).total_manip("bool").value})
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

arrayMod["include"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1)
  Value.new("bool", first.include?(second))
end)

arrayMod["any"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("fun")
  Value.new("bool", first.any?{|x| second.call([x]).total_manip("bool").value})
end)

arrayMod["all"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1).total_manip("fun")
  Value.new("bool", first.all?{|x| second.call([x]).total_manip("bool").value})
end)

arrayMod["foldl"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("array").value
  second = look_at(array, 1)
  third = look_at(array, 2).total_manip("fun")
  first.inject(second){|memo, value| third.call([memo, value])}
end)

$vars.set_value("Array", Value.new("struct", arrayMod))
