def sorteur(array)
	element = arr(calc(look_at(array, 0, [])))
	element.sort!
	element
end
def head(array)
	element = arr(calc(look_at(array, 0, [])))
	if element == []
		[]
	else
		element[0]
	end
end
def tail(array)
	element = arr(calc(look_at(array, 0, [])))
	if element == []
		[]
	else
		element[1..-1 ]
	end
end
def somme_arr(array)
	element = arr(calc(look_at(array, 0, [])))
	element.map!{|i| int(i)}
	element = element.reduce(:+)
	element
end
def product_arr(array)
	element = arr(calc(look_at(array, 0, [])))
	element.map!{|i| int(i)}
	element = element.reduce(:*)
	element
end
def rangex(array)
	mini = int(calc(look_at(array, 0, 0)))
	maxi = int(calc(look_at(array, 1, (mini-1))))
	if maxi < mini
		maxi = mini
		mini = 0
	end
	(mini..maxi).to_a
end
def range(array)
	mini = int(calc(look_at(array, 0, 0)))
	maxi = int(calc(look_at(array, 1, (mini-1))))
	if maxi < mini
		maxi = mini
		mini = 0
	end
	(mini..maxi)
end
def repeat(array)
	element = calc(look_at(array, 0, ""))
	fois = int(calc(look_at(array, 1, 0)))
	(1..fois).to_a.map{|i| element}
end
def prepend(array)
	element = arr(calc(look_at(array, 0, [])))
	valeur = calc(look_at(array, 1, ""))
	[valeur] + element
end
def append(array)
	element = arr(calc(look_at(array, 0, [])))
	valeur = calc(look_at(array, 1, ""))
	element + [valeur]
end
def filter(array)
	element = arr(calc(look_at(array, 0, [])))
	iter = str(calc(look_at(array, 1, "")))
	action = str(look_at(array, 2, ""))
	newarr = []
	element.each do |i|
		$variables.add(iter, i)
		if bool(calc(action))
			newarr << i
		end
	end
	newarr
end
def map(array)
	element = arr(calc(look_at(array, 0, [])))
	iter = str(calc(look_at(array, 1, "")))
	action = str(look_at(array, 2, ""))
	newarr = []
	element.each do |i|
		$variables.add(iter, i)
		newarr << calc(action)
	end
	newarr
end
def len_arr(array)
	element = arr(calc(look_at(array, 0, [])))
	element.length
end
def at_arr(array)
	element = arr(calc(look_at(array, 0, [])))
	iter = int(calc(look_at(array, 1, 0)))
	if element != []
		calc = iter%element.length
		element[calc]
	else
		""
	end
end
def slice_arr(array)
	element = arr(calc(look_at(array, 0, [])))
	iter = int(calc(look_at(array, 1, 0)))
	iterb = int(calc(look_at(array, 2, 0)))
	element[iter..iterb]
end
def include_arr(array)
	element = arr(calc(look_at(array, 0, [])))
	item = (calc(look_at(array, 1, 0)))
	element.include?(item)
end
def concat_arr(array)
	element = arr(calc(look_at(array, 0, [])))
	elementb = arr(calc(look_at(array, 1, [])))
	element + elementb
end
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