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
