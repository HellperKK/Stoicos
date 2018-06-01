##Modif de string
stringMod = Hash.new($vars.unit)

stringMod["make"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  second = look_at(array, 1).total_manip("int").value
  Value.new("string", first * second)
end)

stringMod["get"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  second = look_at(array, 1).total_manip("int").value
  Value.new("string", look_at(first, second))
end)

stringMod["set"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  second = look_at(array, 1).total_manip("int").value
  third = look_at(array, 2).total_manip("string").value
  first[second] = third
  Value.new("string", first)
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

stringMod["include"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  second = look_at(array, 1).total_manip("string").value
  Value.new("bool", first.include?(second))
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

stringMod["format"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  second = look_at(array, 1).total_manip("array").value.map{|i| i.total_manip("string").value}
  resultat = first.clone
  second.each{|i| resultat.sub!("{}", i)}
  Value.new("string", resultat)
end)

stringMod["upcase"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  Value.new("string", first.upcase)
end)

stringMod["downcase"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  Value.new("string", first.downcase)
end)

stringMod["reverse"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  Value.new("string", first.reverse)
end)

stringMod["chars_code"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  Value.new("array", first.bytes.map{|i| Value.new("int", i)})
end)

stringMod["map"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  second = look_at(array, 1).total_manip("fun")
  Value.new("string",first.split("").map{|item| second.call([Value.new("string", item)])}.join(""))
end)

stringMod["mapi"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  second = look_at(array, 1).total_manip("fun")
  Value.new("string",first.split("").each_with_index.map{|item, index| second.call([Value.new("string", item), Value.new("int", index)])}.join(""))
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

stringMod["foldl"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("string").value
  second = look_at(array, 1)
  third = look_at(array, 2).total_manip("fun")
  first.split("").map{|i| Value.new("string", i)}.inject(second){|memo, value| third.call([memo, value])}
end)

$vars.set_value("String", Value.new("struct", stringMod))
