def cust_do(array)
	a = Vide.new(nil)
	array.each{|i| a = i.calc}
	a
end
#~ def proc_w(array)
	#~ array.map{|i| i.to_string}
#~ end
def proc_r(array)
	element = array.fetch(0, Vide.new(nil))
	element.get.calculate
end
def cust_each(array)
	tableau = array.fetch(0, Vide.new(nil)).calc.to_array
	iterateur = array.fetch(1, Vide.new(nil)).calc.to_var
	action = array.fetch(2, Vide.new(nil)).get
	a = Vide.new(nil)
	tableau.each do |i|
		$variables.replace(iterateur, i)
		a = action.calculate
	end
	a
end
def cust_each_index(array)
	tableau = array.fetch(0, Vide.new(nil)).calc.to_array
	iterateur = array.fetch(1, Vide.new(nil)).calc.to_var
	action = array.fetch(2, Vide.new(nil)).get
	a = ""
	tableau.each_index do |i|
		$variables.replace(iterateur, Entier.new(i))
		a = action.calculate
	end
	a
end
def cust_each_with_index(array)
	tableau = array.fetch(0, Vide.new(nil)).calc.to_array
	iterateur = array.fetch(1, Vide.new(nil)).calc.to_var
	iterbis = array.fetch(2, Vide.new(nil)).calc.to_var
	action = array.fetch(3, Vide.new(nil)).get
	a = ""
	tableau.each_with_index do |i, y|
		$variables.replace(iterateur, i)
		$variables.replace(iterbis, Entier.new(y))
		a = action.calculate
	end
	a
end
def cust_each_char(array)
	tableau = array.fetch(0, Vide.new(nil)).calc.to_string
	iterateur = array.fetch(1, Vide.new(nil)).calc.to_var
	action = array.fetch(2, Vide.new(nil)).get
	a = Vide.new(nil)
	tableau.each_char do |i|
		$variables.replace(iterateur, Chaine.new(i))
		a = action.calculate
	end
	a
end
def cust_upto(array)
	min = array.fetch(0, Vide.new(nil)).calc.to_int
	max = array.fetch(1, Vide.new(nil)).calc.to_int
	iterateur = array.fetch(2, Vide.new(nil)).calc.to_var
	action = array.fetch(3, Vide.new(nil)).get
	a = Vide.new(nil)
	min.upto(max) do |i|
		$variables.replace(iterateur, Entier.new(i))
		a = action.calculate
	end
	a
end
def cust_downto(array)
	max = array.fetch(0, Vide.new(nil)).calc.to_int
	min = array.fetch(1, Vide.new(nil)).calc.to_int
	iterateur = array.fetch(2, Vide.new(nil)).calc.to_var
	action = array.fetch(3, Vide.new(nil)).get
	a = Vide.new(nil)
	max.downto(min) do |i|
		$variables.replace(iterateur, Entier.new(i))
		a = action.calculate
	end
	a
end
def cust_times(array)
	fois = array.fetch(0, Vide.new(nil)).calc.to_int
	action = array.fetch(1, Vide.new(nil)).get
	a = Vide.new(nil)
	fois.times{a = action.calculate}
	a
end
def cust_while(array)
	bool = array.fetch(0, Vide.new(nil)).get
	action = array.fetch(1, Vide.new(nil)).get
	a = Vide.new(nil)
	while bool.to_bool && $break
		#puts $variables.get_value("entier")
		a = action.calculate
	end
	$break = true
	a
end

def cust_if(array)
	bool = array.fetch(0, Vide.new(nil)).get
	action = array.fetch(1, Vide.new(nil)).get
	actionb = array.fetch(2, Vide.new(nil)).get
	if bool.to_bool
		action.calculate
	else
		actionb.calculate
	end
end
def cust_case(array)
	array.map!{|i| i.get}
	if (array.length % 2) == 1
		autre = array[-1]
	else
		autre = ""		
	end
	tableau = arr_zip(array)
	b = false
	tableau.each do |i|
		if i[0].to_bool
			return i[1].calculate
		end
	end
	return autre.calculate
end
def pass(array)
	Vide.new(nil)
end
