def incr(array)
	element = int(calc(look_at(array, 0, 0)))
	(element + 1)
end
def decr(array)
	element = int(calc(look_at(array, 0, 0)))
	(element - 1)
end
def somme(array)
	element = int(calc(look_at(array, 0, 0)))
	ajout = int(calc(look_at(array, 1, 0)))
	element + ajout
end
def difference(array)
	element = int(calc(look_at(array, 0, 0)))
	ajout = int(calc(look_at(array, 1, 0)))
	element - ajout
end
def produit(array)
	element = int(calc(look_at(array, 0, 0)))
	ajout = int(calc(look_at(array, 1, 0)))
	element * ajout
end
def division(array)
	element = int(calc(look_at(array, 0, 0)))
	ajout = int(calc(look_at(array, 1, 0)))
	element / ajout
end
def modulo(array)
	element = int(calc(look_at(array, 0, 0)))
	ajout = int(calc(look_at(array, 1, 0)))
	element % ajout
end
def puissance(array)
	element = int(calc(look_at(array, 0, 0)))
	ajout = int(calc(look_at(array, 1, 0)))
	element**ajout
end
def divisible(array)
	element = int(calc(look_at(array, 0, 0)))
	ajout = int(calc(look_at(array, 1, 0)))
	(element % ajout == 0)
end
def even(array)
	element = int(calc(look_at(array, 0, 0)))
	(element % 2 == 0)
end
def odd(array)
	element = int(calc(look_at(array, 0, 0)))
	(element % 2 == 1)
end