def ord(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_string
	Entier.new(element.ord)
end