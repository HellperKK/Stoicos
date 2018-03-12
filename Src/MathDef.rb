mathMod = Hash.new($vars.unit)

mathMod["E"] = Value.new("float", Math::E)

mathMod["PI"] = Value.new("float", Math::PI)

mathMod["sqrt"] = NativeFunction.new("fun", lambda do |array|
  first = look_at(array, 0).total_manip("float").value
  Value.new("float", Math.sqrt(first))
end)

$vars.set_value("Math", Value.new("struct", mathMod))
