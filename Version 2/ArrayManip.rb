def sorteur(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_array
	Tableau.new(element.sort)
end
def head(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_array
	if element == []
		Vide.new(nil)
	else
		element[0]
	end
end
def tail(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_array
	if element == []
		Tableau.new([])
	else
		Tableau.new(element[1..-1 ])
	end
end
def somme_arr(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_array
	Entier.new(element.map{|i| i.to_int}.reduce(:+))
end
def product_arr(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_array
	Entier.new(element.map{|i| i.to_int}.reduce(:*))
end
def range(array)
	mini = array.fetch(0, Vide.new(nil)).calc.to_int
	maxi = array.fetch(1, Entier.new(mini-1)).calc.to_int
	if maxi < mini
		maxi = mini
		mini = 0
	end
	Tableau.new((mini..maxi).to_a.map{|i| Entier.new(i)})
end
def repeat(array)
	element = array.fetch(0, Vide.new(nil)).calc
	fois = array.fetch(1, Entier.new(mini-1)).calc.to_int
	Tableau.new(Array.new(fois){element})
end
def filter(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_array
	iter = array.fetch(1, Vide.new(nil)).calc.to_var
	action = array.fetch(2, Vide.new(nil)).get
	#puts [element, iter, action].to_s
	newarr = []
	element.each do |i|
		$variables.replace(iter, i)
		if action.to_bool
			newarr << i
		end
	end
	Tableau.new(newarr)
end
def map(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_array
	iter = array.fetch(1, Vide.new(nil)).calc.to_var
	action = array.fetch(2, Vide.new(nil)).get
	newarr = []
	element.each do |i|
		$variables.replace(iter, i)
		newarr << action.calculate
	end
	Tableau.new(newarr)
end
def mapi(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_array
	iter = array.fetch(1, Vide.new(nil)).calc.to_var
	iterbis = array.fetch(2, Vide.new(nil)).calc.to_var
	action = array.fetch(3, Vide.new(nil)).get
	newarr = []
	element.each_with_index do |item, index|
		$variables.replace(iter, item)
		$variables.replace(iterbis, Entier.new(index))
		newarr << action.calculate
	end
	Tableau.new(newarr)
end
def inject(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_array
	iter = array.fetch(1, Vide.new(nil)).calc.to_var
	iterbis = array.fetch(2, Vide.new(nil)).calc.to_var
	action = array.fetch(3, Vide.new(nil)).get
	$variables.add(iter, element[0])
	element = element[1..-1]
	element.each do |i|
		$variables.replace(iterbis, i)
		$variables.replace(iter, action.calculate)
	end
	$variables.get_value(iter)
end
def cust_reverse_arr(array)
	array.fetch(0, Vide.new(nil)).calc.to_array
	Tableau.new(element.reverse)
end
def len_arr(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_array
	Entier.new(element.length)
end
def at_arr(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_array
	iter = array.fetch(1, Vide.new(nil)).calc.to_int
	if element != []
		calc = iter%element.length
		element[calc]
	else
		Vide.new(nil)
	end
end
def slice_arr(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_array
	iter = array.fetch(1, Vide.new(nil)).calc.to_int
	iterb = array.fetch(2, Vide.new(nil)).calc.to_int
	Tableau.new(element[iter..iterb])
end
def include_arr(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_array
	item = array.fetch(1, Vide.new(nil)).calc
	Booleen.new(element.map{|i| i.valeur}.include?(item.valeur))
end
def concat_arr(array)
	element = array.fetch(0, Vide.new(nil)).calc.to_array
	elementb = array.fetch(1, Vide.new(nil)).calc.to_array
	Tableau.new(element + elementb)
end
##################
def remove(array)
	element = arr(calc(look_at(array, 0, [])))
	item = (calc(look_at(array, 1, 0)))
	index = element.index(item)
	unless index == nil
		element.delete_at(index)
	end
	element
end
def remove_all(array)
	element = arr(calc(look_at(array, 0, [])))
	item = (calc(look_at(array, 1, 0)))
	element.delete(item)
	element
end