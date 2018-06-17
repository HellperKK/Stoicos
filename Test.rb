require_relative "Stoicos.rb"

files = Dir["Examples/*.txt"]
files.each do |i|
  puts "Lecture du fichier #{i}"
  execute_file(i)
end
