require_relative "Src/VarManip"
require_relative "Src/Conversion"
$vars = Vars.new
require_relative "Src/StdDef"
require_relative "Src/StringDef"
require_relative "Src/ArrayDef"
require_relative "Src/MathDef"
require_relative "Src/GameDef"
require_relative "Src/StructDef"
require_relative "Src/FileManager"
require_relative "Src/MapDef"
require_relative "Src/UnsafeDef"
$vars.add_stack

def chercheFonc(tab)
	begin
		fonction = tab[0].total_manip("fun")
		arguments = tab[1..-1].map{|i| i.calc.get}
		arguments = [] if arguments == nil
		fonction.call(arguments)
	rescue StandardError => e
		puts "there has been an accident ! #{e.message}"
		# puts tab.to_s
		# puts e.backtrace.inspect
		$vars.unit
	end
end

def look_at(array, indice)
	array.fetch(indice, $vars.unit)
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

###########################################
##Parseurs
###########################################
def find_string(text)
	reg = /^"(\\"|[^"])*"/
	if reg.match?(text)
		return reg.match(text)[0].length - 1
	else
		return text.length - 1
	end
end

def find_second(text, char, index=1)
	if index == text.length
		raise "outRange"
	elsif text[index] == char
		index
	else
		find_second(text, char, index+1)
	end
end

def find_matching(text, char, charbis, index=1, compteur=1)
	if compteur == 0
		index - 1
	elsif text[index] == char
		find_matching(text, char, charbis, index+1, compteur-1)
	elsif text[index] == charbis
		find_matching(text, char, charbis, index+1, compteur+1)
	elsif index == text.length
		raise "outRange"
	else
		find_matching(text, char, charbis, index+1, compteur)
	end
end

def parseur(line)
	line = line.strip
	if line == ""
		return []
	else
		begin
			case line[0]
			#~ when "'" then point = find_second(line, "'")
			when '"' then point = find_string(line)
			when "(" then point = find_matching(line, ")", "(")
			when "[" then point = find_matching(line, "]", "[")
			when "{" then point = find_matching(line, "}", "{")
			else point = find_second(line, " ") - 1
			end
			[to_objet(line[0..point])] + parseur(line[(point + 1)..-1])
		rescue
			[to_objet(line)]
		end
	end
end

def concatLine(texte)
	tab = texte.split("\n")
	(tab.length-1).downto(0) do |i|
		if tab[i].strip[0] == ";"
			tab.delete_at(i)
		end
	end
	(tab.length-1).downto(1) do |i|
		if ((tab[i][0] == " ")||(tab[i][0] == "\t"))
			cont = tab[i].strip
			tab[i-1] += " #{cont}"
			tab.delete_at(i)
		end
	end
	tab[0] = tab[0].strip
	tab
end

def execute_file(name)
	lire = true
	contenu = File.open(name, 'r'){|i| i.read}
	contenuTab = concatLine(contenu)
	contenuTab.each do |i|
		if i == "=begin"
			lire = false
		elsif i == "=end"
			lire = true
		else
			unless (i == "") || (i[0] == "#") || (not lire)
				tab = parseur(i)
				chercheFonc(tab)
			end
		end
	end
	contenuTab
end

###########################################
##Debut du programme
###########################################
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

t1 = Time.now
principal = execute_file($chemin.main)
contenu = principal.join("\n")
f = File.open('Output.txt','w'){|i| i.write(contenu)}
t2 = Time.now
# print "\n"
# puts t2 - t1
# puts $vars.get_stack.each{|key, value| puts "#{key} #{value}"}
