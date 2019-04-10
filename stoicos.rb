require_relative "lexer.rb"

args = ARGV
if args != []
	ouvrir = args[0]
else
	ouvrir = "./Main.txt"
end

if File.file?(ouvrir)
	$chemin = FileManager.new(File.dirname(ouvrir), File.basename(ouvrir))
elsif File.directory?(ouvrir)
	$chemin = FileManager.new(ouvrir, "Main.txt")
else
	$chemin = FileManager.new(".", "Main.txt")
end

texte = File.open($chemin.main, "r"){|file| file.read}
tokens = lex(texte)
