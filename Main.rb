require_relative "Conversion"
require_relative "StringManip"
require_relative "IntManip"
require_relative "ArrayManip"
require_relative "VarManip"
require_relative "BoolManip"
require_relative "ProcManip"
args = ARGV
def chercheFonc(tab)
	fonction = tab[0]
	arguments = tab[1..-1]
	case fonction
	#fonctions generales
	when "print" then cust_print(arguments)
	when "input" then cust_get(arguments)
	#fonctions manip variables
	when "allocate_var" then allocate_var(arguments)
	when "read_var" then read_var(arguments)
	when "swap_var" then swap_var(arguments)
	when "let_in" then let_in(arguments)
	when "increment" then increment(arguments)
	when "decrement" then decrement(arguments)
	#fonctions de conversion
	when "arr" then arr(arguments)
	#fonctions manip string
	when "repeat_s" then repeat_s(arguments)
	when "capitalize" then cust_capitalize(arguments)
	when "upcase" then cust_upcase(arguments)
	when "downcase" then cust_downcase(arguments)
	when "swapcase" then cust_swapcase(arguments)
	when "title" then title(arguments)
	when "reverse" then cust_reverse(arguments)
	when "split" then cust_split(arguments)
	when "format" then cust_format(arguments)
	when "at_s" then at_s(arguments)
	when "slice_s" then slice_s(arguments)
	when "include_s" then include_s(arguments)
	when "concat_s" then concat_s(arguments)
	#fonctions manip int
	when "incr" then incr(arguments)
	when "decr" then decr(arguments)
	when "sum" then somme(arguments)
	when "dif" then difference(arguments)
	when "prod" then produit(arguments)
	when "div" then division(arguments)
	when "mod" then modulo(arguments)
	when "pow" then puissance(arguments)
	when "+" then somme(arguments)
	when "-" then difference(arguments)
	when "*" then produit(arguments)
	when "/" then division(arguments)
	when "%" then modulo(arguments)
	when "**" then puissance(arguments)
	when "divisible" then divisible(arguments)
	when "even" then even(arguments)
	when "odd" then odd(arguments)
	#fonctions  manip array
	when "rangex" then rangex(arguments)
	when "range" then range(arguments)
	when "head" then head(arguments)
	when "tail" then tail(arguments)
	when "sort" then sorteur(arguments)
	when "sum_arr" then somme_arr(arguments)
	when "prod_arr" then product_arr(arguments)
	when "repeat" then repeat(arguments)
	when "prepend" then repend(arguments)
	when "append" then append(arguments)
	when "remove" then remove(arguments)
	when "remove_all" then remove_all(arguments)
	when "filter" then filter(arguments)
	when "map" then map(arguments)
	when "len_arr" then len_arr(arguments)
	when "at_arr" then at_arr(arguments)
	when "slice_arr" then slice_arr(arguments)
	when "include_arr" then include_arr(arguments)
	when "concat_arr" then concat_arr(arguments)
	#fonctions  manip bool
	when "and" then cust_and(arguments)
	when "or" then cust_or(arguments)
	when "not" then cust_not(arguments)
	when "equal" then equal(arguments)
	when "different" then different(arguments)
	when "inf" then inf(arguments)
	when "sup" then sup(arguments)
	when "infeq" then infeq(arguments)
	when "supeq" then supeq(arguments)
	when "true" then cust_true(arguments)
	when "false" then cust_false(arguments)
	#fonctions  manip proc
	when "do" then cust_do(arguments)
	when "proc_w" then proc_w(arguments)
	when "proc_r" then proc_r(arguments)
	when "each" then cust_each(arguments)
	when "each_char" then cust_each_char(arguments)
	when "while" then cust_while(arguments)
	when "if" then cust_if(arguments)
	when "case" then cust_case(arguments)
	when "pass" then pass(arguments)
	#fonction erreur
	else  "Instruction inconnue"
	end
end
def arr_zip(array)
	if array.length < 2
		[]
	else
		[array[0..1]] + arr_zip(array[2..-1])
	end
end
def look_at(array, indice, save)
	if indice <= (array.length-1)
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
	element.strip
end
def cust_get(array)
	element = str(calc(look_at(array, 0, "")))
	print element
	$stdin.gets
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
	#tab.each{|i| puts "|" + i + "|"}
	#puts"___"
	chercheFonc(tab)
end
def execute_file(name)
	lire = true
	contenu = File.open(name, 'r').read
	contenuTab = concatLine(contenu)
	contenuTab.each do |i|
		if i == "=begin"
			lire = false
		elsif i == "=end"
			lire = true
		else
			unless i[0] == "#" or (not lire)
				exec(i)
			end
		end
	end
	contenuTab
end
###########################################
##Début du programme
###########################################
if args != []
	ouvrir = args[0]
else
	ouvrir = "Test.txt"
end
t1 = Time.now
$variables = Hash.new("")
principal = execute_file(ouvrir)
contenu = ""
principal.each{|i| contenu += "#{i}\n"}
f = File.open('Output.txt','w')
f.write(contenu)
f.close
t2 = Time.now
puts t2 - t1
#puts "|#{$variables["probleme4"]}|"