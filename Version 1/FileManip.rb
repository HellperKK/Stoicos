def cust_require(array)
	element = str(calc(look_at(array, 0, "")))
	unless $required.include?(element) || (not File.file?("#{element}.txt"))
		execute_file("#{element}.txt")
		$required << element
	end
	""
end
def cust_open_read(array)
	element = str(calc(look_at(array, 0, "")))
	unless element == "" || (not File.file?(element))
		file = File.open(element, "r")
		content = file.read
		file.close
		return content
	end
	""
end
def cust_open_write(array)
	element = str(calc(look_at(array, 0, "")))
	contenu = str(calc(look_at(array, 1, "")))
	unless element == ""
		file = File.open(element, "w")
		file.write(contenu)
		file.close
		contenu
	end
end
def exist_f(array)
	element = str(calc(look_at(array, 0, "")))
	if element != ""
		File.file?(element)
	else 
		false
	end
end