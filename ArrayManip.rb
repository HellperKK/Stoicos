def sorteur(array)
	element = arr(calc(look_at(array, 0, "")))
	element.sort!
	element
end
def somme(array)
	element = arr(calc(look_at(array, 0, "")))
	element.map!{|i|int(i)}
	element = element.reduce(:+)
	element
end
