$vars.set_value("test", NativeFunction.new("fun", lambda do |array|
  puts "it is a test"
  $vars.unit
end))
