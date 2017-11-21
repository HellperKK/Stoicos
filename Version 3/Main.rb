require_relative "VarManip"
require_relative "Conversion"
require_relative "StdDef"
#~ require_relative "CharManip"
#~ require_relative "StringManip"
#~ require_relative "IntManip"
#~ require_relative "ArrayManip"
#~ require_relative "BoolManip"
#~ require_relative "ProcManip"
#require_relative "FileManip"
def chercheFonc(tab)
	tab.map!{|x| x.get}
	fonction = tab[0]
	arguments = tab[1..-1]
	#~ puts arguments.to_s
	fonction.convert("fun").call(arguments)
end
def arr_zip(array)
	if array.length < 2
		[]
	else
		[array[0..1]] + arr_zip(array[2..-1])
	end
end
#~ def look_at(array, indice, save)
	#~ if indice <= (array.length-1)
		#~ array[indice]
	#~ else
		#~ save
	#~ end
#~ end
def calc(arg)
	arg.calc
end
def cust_print(array)
	element = array.map{|i| i.calc.to_string}
	a = element.join(" ")
	puts a
	Chaine.new(a)
end
def cust_get(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_string
	print element
	Chaine.new($stdin.gets.strip)
end
def cust_break(array)
	$break = false
	Vide.new(nil)
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
			when "'" then point = find_second(line, "'")
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
		if ((tab[i][0] == " ")||(tab[i][0] == "\t") )&& (i > 0)
			cont = tab[i].strip
			tab[i-1] += " #{cont}"
			tab.delete_at(i)
		end
	end
	tab[0] = tab[0].strip 
	tab
end

def exec(line)
	tab = parseur(line)
	chercheFonc(tab)
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
			unless (i[0] == "#") || (not lire)
				exec(i)
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
$vars = Vars.new
std_init
#~ $break = true
#~ $required = []
principal = execute_file(ouvrir)
contenu = principal.join("\n")
f = File.open('Output.txt','w'){|i| i.write(contenu)}
t2 = Time.now
puts ""
puts t2 - t1
#puts $variables
#puts "|#{$variables["probleme4"]}|"