require_relative "src/values/Value.rb"
require_relative "src/values/FunCall.rb"
require_relative "src/values/Function.rb"
require_relative "src/values/NativeFunction.rb"
require_relative "src/values/Ident.rb"

require_relative "src/parsing/LexRule.rb"
require_relative "src/parsing/Lexer.rb"

require_relative "src/FileManager.rb"

require_relative "src/variables/Variable.rb"
require_relative "src/variables/VariableManager.rb"

VariableManager.vars = VariableManager.new

require_relative "src/stdDef.rb"

def look_at(array, indice)
	array.fetch(indice, VariableManager.vars.get_value("unit"))
end

def look_at_value(value, indice)
	begin
		value.value.fetch(indice, $vars.unit)
	rescue
		value
	end
end

def same_size(array, arrayb)
	array.each_with_index.map{|e, i| look_at(arrayb, i)}
end

args = ARGV
if args != []
	ouvrir = args[0]
else
	ouvrir = "./main.txt"
end

if File.file?(ouvrir)
	$chemin = FileManager.new(File.dirname(ouvrir), File.basename(ouvrir))
elsif File.directory?(ouvrir)
	$chemin = FileManager.new(ouvrir, "main.txt")
else
	$chemin = FileManager.new(".", "main.txt")
end

texte = File.open($chemin.main, "r"){|file| file.read}
tokens = Lexer.new.lex(texte)
tokens.each do |tok|
	tok.calc
end
