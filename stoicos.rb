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
