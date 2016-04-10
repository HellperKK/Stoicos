def cust_do(array)
	a = ""
	array.each{|i| a = calc(i)}
	a
end
def proc_w(array)
	array.map{|i| str(i)}
end
def proc_r(array)
	element = arrbis (calc(look_at(array, 0, [])))
	a = ""
	element.each{|i| a = calc(i)}
	a
end
def cust_each(array)
	tableau = arr(calc(look_at(array, 0, [])))
	iterateur = str(calc(look_at(array, 1, "i")))
	action = look_at(array, 2, "")
	a = ""
	tableau.each do |i|
		$variables.replace(iterateur, i)
		a = calc(action)
	end
	a
end
def cust_each_index(array)
	tableau = arr(calc(look_at(array, 0, [])))
	iterateur = str(calc(look_at(array, 1, "i")))
	action = look_at(array, 2, "")
	a = ""
	tableau.each_index do |i|
		$variables.replace(iterateur, i)
		a = calc(action)
	end
	a
end
def cust_each_with_index(array)
	tableau = arr(calc(look_at(array, 0, [])))
	iterateur = str(calc(look_at(array, 1, "i")))
	iterbis = str(calc(look_at(array, 2, "y")))
	action = look_at(array, 3, "")
	a = ""
	tableau.each_with_index do |i, y|
		$variables.replace(iterateur, i)
		$variables.replace(iterbis, y)
		a = calc(action)
	end
	a
end
def cust_each_char(array)
	tableau = str(calc(look_at(array, 0, [])))
	iterateur = str(calc(look_at(array, 1, "i")))
	action = look_at(array, 2, "")
	a = ""
	tableau.each_char do |i|
		$variables.replace(iterateur, i)
		a = calc(action)
	end
	a
end
def cust_upto(array)
	min = int(calc(look_at(array, 0, 0)))
	max = int(calc(look_at(array, 1, 0)))
	iterateur = str(calc(look_at(array, 2, "i")))
	action = look_at(array, 3, "")
	a = ""
	min.upto(max) do |i|
		$variables.replace(iterateur, i)
		a = calc(action)
	end
	a
end
def cust_downto(array)
	max = int(calc(look_at(array, 0, 0)))
	min = int(calc(look_at(array, 1, 0)))
	iterateur = str(calc(look_at(array, 2, "i")))
	action = look_at(array, 3, "")
	a = ""
	max.downto(min) do |i|
		$variables.replace(iterateur, i)
		a = calc(action)
	end
	a
end
def cust_times(array)
	fois = int(calc(look_at(array, 0, 0)))
	action = look_at(array, 1, "")
	a = ""
	fois.times{a = calc(action)}
	a
end
def cust_while(array)
	bool = look_at(array, 0, false)
	action = look_at(array, 1, "")
	a = ""
	while calc(bool)
		a = calc(action)
	end
	a
end
def cust_if(array)
	bool = look_at(array, 0, false)
	action = look_at(array, 1, "")
	actionb = look_at(array, 2, "")
	if calc(bool)
		calc(action)
	else
		calc(actionb)
	end
end
def cust_case(array)
	if (array.length % 2) == 1
		autre = array[-1]
	else
		autre = ""		
	end
	tableau = arr_zip(array)
	b = false
	tableau.each do |i|
		if bool(calc(i[0]))
			return calc(i[1])
		end
	end
	return calc(autre)
end
def pass(array)
	""
end
