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
def title(array)
	element = str(calc(look_at(array, 0, "")))
	liste = element.split(" ")
	liste.map!{|i| i.capitalize}
	element = liste.join(" ")
	element
end
