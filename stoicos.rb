require_relative "src/values.rb"
require_relative "src/lexer.rb"
require_relative "src/fileManager.rb"
require_relative "src/eval.rb"
require_relative "src/variables.rb"

$vars = Vars.new

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
tokens = lex(texte)
tokens.each do |i|
	i.calc
end
puts tokens.to_s
