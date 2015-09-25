require_relative "Conversion"
require_relative "StringManip"
require_relative "IntManip"
require_relative "ArrayManip"
def chercheFonc(tab)
	fonction = tab[0]
	arguments = tab[1..-1]
	case fonction
	#fonctions generales
	when "print" then cust_print(arguments)
	#fonctions generales
	when "arr" then arr(arguments)
	#fonctions manip string
	when "repeat_s" then repeat_s(arguments)
	when "capitalize" then cust_capitalize(arguments)
	when "upcase" then cust_upcase(arguments)
	#fonctions manip int
	when "incr" then incr(arguments)
	when "decr" then decr(arguments)
	#fonction manip array
	when "sort" then sorteur(arguments)
	when "sum" then somme(arguments)
	#fonctions erreur
	else  "Instruction inconnue"
	end
end
def look_at(array, indice, save)
	if indice <= (array.length - 1)
		array[indice]
	else
		save
	end
end
def calc(arg)
	argstr = str(arg)
	if argstr[0] == "("
		argstr = argstr[1..-2]
		arg = calc(chercheFonc(parseur(argstr)))
	end
	arg	
end
def cust_print(array)
	element = str(calc(look_at(array, 0, "")))
	puts element
	""
end
def parseur(line)
	line = line.strip
	point = 0
	if line == ""
		return []
	elsif (not line.include?(" "))
		return [line]
	else
		if line[point] == "'"
			point += 1 
			while line[point] != "'"
				point += 1
			end
		elsif line[point] == "("
			point += 1 
			compteur = -1
			while compteur != 0
				if line[point] == ")"
					compteur += 1
				elsif line[point] == "("
					compteur -= 1
				end
				point += 1
			end
			point -= 1
		elsif line[point] == "["
			point += 1 
			compteur = -1
			while compteur != 0
				if line[point] == "]"
					compteur += 1
				elsif line[point] == "["
					compteur -= 1
				end
				point += 1
			end
			point -= 1
		else
			point += 1 
			while line[point] != " "
				point += 1
			end
			point -= 1
		end
		#puts "[#{line}]"
		[line[0..point]] + parseur(line[(point+1)..-1])
	end
end
def concatLine(texte)
	tab = texte.split("\n")
	(tab.length-1).downto(0) do |i|
		if (tab[i][0] == " ") && (i > 0)
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
	#tab.each{|i| puts "|" + i + "|"}
	#puts"___"
	chercheFonc(tab)
end
contenu = File.open('Input.txt','r').read
contenuTab = concatLine(contenu)
contenuTab.each do |i| 
	unless i[0] == "#"
		exec(i)
	end
end
contenu = ""
contenuTab.each{|i| contenu += "#{i}\n"}
f = File.open('Output.txt','w')
f.write(contenu)
f.close
