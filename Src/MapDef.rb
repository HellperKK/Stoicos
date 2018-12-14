mapMod = Hash.new($vars.unit)

mapMod["empty"] = Value.new("map", Hash.new($vars.unit))

mapMod["singleton"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0)
  second = look_at(array, 1)
  map = Hash.new($vars.unit)
  map[first] = second
  Value.new("map", map)
end)

mapMod["from_pairs"] = NativeFunction.new("fun", lambda do |array|
  first = array.map{|e| e.total_manip("array").value}
  map = Hash.new($vars.unit)
  first.each do |element|
    index = look_at(element, 0)
    map[index] = look_at(element, 1)
  end
  Value.new("map", map)
end)

mapMod["get"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("map").value
  second = look_at(array, 1)
  first[second]
end)

mapMod["set"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("map").value
  second = look_at(array, 1)
  third = look_at(array, 2)
  first = first.clone
  first[second] = third
  Value.new("map", first)
end)

mapMod["set_fun"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("map").value
  second = look_at(array, 1)
  third = look_at(array, 2).total_manip("fun")
  first = first.clone
  first[second] = third.call([first[second]])
  Value.new("map", first)
end)

mapMod["pairs"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("map").value
  tab = first.to_a.map{|p| Value.new("array", p)}
  Value.new("array", tab)
end)

mapMod["keys"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("map").value.keys
  Value.new("array", first)
end)

mapMod["values"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("map").value.values
  Value.new("array", first)
end)

$vars.set_value("Map", Value.new("struct", mapMod))
