def repeat_s(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_string
	fois = array.fetch(1, Vide.new(nil)).calc.to_int
	taille = element.length * fois
	Chaine.new("".rjust(taille, element))
end
def cust_capitalize(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_string
	Chaine.new(element.capitalize)
end
def cust_upcase(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_string
	Chaine.new(element.upcase)
end
def cust_downcase(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_string
	Chaine.new(element.downcase)
end
def cust_swapcase(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_string
	Chaine.new(element.swapcase)
end
def title(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_string
	liste = element.split(" ")
	liste.map!{|i| i.capitalize}
	element = liste.join(" ")
	Chaine.new(element)
end
def cust_split(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_string
	separateur = array.fetch(1, Vide.new(nil)).calc.to_string
	if element != ""
		Tableau.new(element.split(separateur))
	else
		Tableau.new([])
	end
end
def cust_join(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_array
	separateur = array.fetch(1, Vide.new(nil)).calc.to_string
	if element != []
		Chaine.new(element.join(separateur))
	else
		Chaine.new("")
	end
end
def cust_format(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_string
	tableau = array.fetch(1, Vide.new(nil)).calc.to_array
	tableau.map!{|i| i.to_string}
	while element.include?("{}")
		tableau.each{|i| element.sub!("{}", "#{i}")}
	end
	Chaine.new(element)
end
def cust_reverse_s(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_string
	Chaine.new(element.reverse)
end
def len_s(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_string
	Entier.new(element.length)
end
def at_s(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_string
	iter = array.fetch(1, Vide.new(nil)).calc.to_int
	if element != ""
		calc = iter%element.length
		Chaine.new(element[calc])
	else
		Chaine.new("")
	end
end
def slice_s(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_string
	iter = array.fetch(1, Vide.new(nil)).calc.to_int
	iterb = array.fetch(2, Vide.new(nil)).calc.to_int
	Chaine.new(element[iter..iterb])
end
def include_s(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_string
	item = array.fetch(1, Vide.new(nil)).calc.to_string
	Booleen.new(element.include?(item))
end
def concat_s(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_string
	elementb = array.fetch(1, Vide.new(nil)).calc.to_string
	Chaine.new(element + elementb)
end