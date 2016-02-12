def cust_require(array)
	element = str(calc(look_at(array, 0, "")))
	unless $required.include?(element)
		execute_file("#{element}.txt")
		$required << element
	end
end