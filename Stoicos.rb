require_relative "VarManip"
require_relative "Conversion"
$vars = Vars.new
require_relative "StdDef"
require_relative "StdDefBis"
def chercheFonc(tab)
	#~ puts tab.to_s
	fonction = tab[0].total_manip("fun")
	arguments = tab[1..-1].map{|i| i.calc}
	#~ puts arguments.to_s
	fonction.call(arguments)
end
def look_at(array, indice)
	if indice <= (array.length-1)
		array[indice]
	else
		$vars.unit
	end
end
###########################################
##Parseurs
###########################################
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

def has_coma(line)
	in_string = false
	line.each_char do |c|
		if c == "\""
			in_string = ! in_string
		elsif (! in_string) && (c == ",")
			return true
		end
	end
	return false
end

def parseur(line)
	line = line.strip
	if line == ""
		return []
	else
		begin
			case line[0]
			#~ when "'" then point = find_second(line, "'")
			when '"' then point = find_second(line, '"')
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
		if ((tab[i][0] == " ")||(tab[i][0] == "\t") )&&(i > 0)
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
	ouvrir = "Test.txt"
end

t1 = Time.now
std_init
std_init_bis
#~ $break = true
#~ $required = []
principal = execute_file(ouvrir)
contenu = principal.join("\n")
f = File.open('Output.txt','w'){|i| i.write(contenu)}
t2 = Time.now
print "\n"
puts t2 - t1
#~ puts $vars
#puts "|#{$variables["probleme4"]}|"
