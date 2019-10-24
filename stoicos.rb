require_relative "src/parsing/LexRule.rb"
require_relative "src/parsing/Token.rb"
require_relative "src/parsing/Lexer.rb"
require_relative "src/FileManager.rb"

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
tokens = $lexer.lex(texte)
puts tokens.to_s
