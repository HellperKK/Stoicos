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
def repeati(array)
	element = int(calc(look_at(array, 0, 0)))
	fois = int(calc(look_at(array, 1, 0)))
	(1..fois).to_a.map{|i| element}
end
def repeat(array)
	element = str(calc(look_at(array, 0, "")))
	fois = int(calc(look_at(array, 1, 0)))
	(1..fois).to_a.map{|i| element}
end
def repeatarr(array)
	element = arr(calc(look_at(array, 0, [])))
	fois = int(calc(look_at(array, 1, 0)))
	(1..fois).to_a.map{|i| element}
end
