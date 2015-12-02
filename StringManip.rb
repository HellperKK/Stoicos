def repeat_s(array)
	element = str(calc(look_at(array, 0, "")))
	fois = int(calc(look_at(array, 1, 0)))
	taille = element.length * fois
	"".rjust(taille, element)
end
def cust_capitalize(array)
	element = str(calc(look_at(array, 0, "")))
	element.capitalize 
end
def cust_upcase(array)
	element = str(calc(look_at(array, 0, "")))
	element.upcase
end
def cust_downcase(array)
	element = str(calc(look_at(array, 0, "")))
	element.downcase
end
def cust_swapcase(array)
	element = str(calc(look_at(array, 0, "")))
	element.swapcase
end
def cust_split(array)
	element = str(calc(look_at(array, 0, "")))
	separateur = str(calc(look_at(array, 1, "")))
	if element != ""
		element.split(separateur)
	else
		[]
	end
end
def cust_format(array)
	element = str(calc(look_at(array, 0, "")))
	tableau = arr(calc(look_at(array, 1, "")))
	tableau.map!{|i| str(i)}
	tableau.each{|i| element.sub!("{}", "#{i}")}
	element
end
def title(array)
	element = str(calc(look_at(array, 0, "")))
	liste = element.split(" ")
	liste.map!{|i| i.capitalize}
	element = liste.join(" ")
	element
end
def cust_reverse(array)
	element = str(calc(look_at(array, 0, "")))
	element.reverse
end
def at_s(array)
	element = str(calc(look_at(array, 0, "")))
	iter = int(calc(look_at(array, 1, 0)))
	if element != ""
		calc = iter%element.length
		element[calc]
	else
		""
	end
end
def slice_s(array)
	element = str(calc(look_at(array, 0, "")))
	iter = int(calc(look_at(array, 1, 0)))
	iterb = int(calc(look_at(array, 2, 0)))
	element[iter..iterb]
end
def include_s(array)
	element = str(calc(look_at(array, 0, "")))
	item = (calc(look_at(array, 1, 0)))
	element.include?(item)
end
def concat_s(array)
	element = str(calc(look_at(array, 0, "")))
	elementb = str(calc(look_at(array, 1, "")))
	element + elementb
end
