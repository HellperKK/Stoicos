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
	tableau.each do |i|
		$variables[iterateur] = i
		calc(action)
	end
	""
end
def cust_each_char(array)
	tableau = str(calc(look_at(array, 0, [])))
	iterateur = str(calc(look_at(array, 1, "i")))
	action = look_at(array, 2, "")
	tableau.each_char do |i|
		$variables[iterateur] = i
		calc(action)
	end
	""
end
def cust_while(array)
	bool = look_at(array, 0, false)
	action = look_at(array, 1, "")
	while calc(bool)
		calc(action)
	end
	""
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
