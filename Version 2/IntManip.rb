def rand_int(array)
	mini = array.fetch(0, Vide.new(nil)).calc.to_int
	maxi = array.fetch(1, Entier.new(mini-1)).calc.to_int
	if maxi < mini
		maxi = mini
		mini = 0
	end
	Entier.new(rand(mini..maxi))
end
def incr(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_int
	Entier.new(element + 1)
end
def decr(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_int
	Entier.new(element - 1)
end
def somme(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_int
	ajout = array.fetch(1, Vide.new(nil)).calc.to_int
	Entier.new(element + ajout)
end
def difference(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_int
	ajout = array.fetch(1, Vide.new(nil)).calc.to_int
	Entier.new(element - ajout)
end
def produit(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_int
	ajout = array.fetch(1, Entier.new(1)).calc.to_int
	Entier.new(element * ajout)
end
def division(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_int
	ajout = array.fetch(1, Entier.new(1)).calc.to_int
	Entier.new(element / ajout)
end
def modulo(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_int
	ajout = array.fetch(1, Entier.new(1)).calc.to_int
	Entier.new(element % ajout)
end
def puissance(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_int
	ajout = array.fetch(1, Entier.new(1)).calc.to_int
	Entier.new(element**ajout)
end
def divisible(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_int
	ajout = array.fetch(1, Entier.new(1)).calc.to_int
	Booleen.new(element % ajout == 0)
end
def even(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_int
	Booleen.new(element % 2 == 0)
end
def odd(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_int
	Booleen.new(element % 2 == 1)
end
def chr(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_int
	Caractere.new(element.chr)
end