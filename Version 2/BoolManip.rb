def cust_and(array)
	bool = array.fetch(0, Vide.new(nil)).calc.to_bool
	boolb = array.fetch(1, Vide.new(nil)).calc.to_bool
	Booleen.new(bool && boolb)
end
def cust_or(array)
	bool = array.fetch(0, Vide.new(nil)).calc.to_bool
	boolb = array.fetch(1, Vide.new(nil)).calc.to_bool
	Booleen.new(bool || boolb)
end
def cust_not(array)
	array.fetch(0, Vide.new(nil)).calc.to_bool
	Booleen.new((not bool))
end
def equal(array)
	val = array.fetch(0, Vide.new(nil)).calc.get
	valb = array.fetch(1, Vide.new(nil)).calc.get
	Booleen.new(val.valeur == valb.valeur)
end
def different(array)
	val = array.fetch(0, Vide.new(nil)).calc.get
	valb = array.fetch(1, Vide.new(nil)).calc.get
	Booleen.new(val.valeur != valb.valeur)
end
############################
def inf(array)
	val = calc(look_at(array, 0, ""))
	valb = calc(look_at(array, 1, ""))
	valb = dynconv(val, valb)
	(val < valb)
end
def sup(array)
	val = calc(look_at(array, 0, ""))
	valb = calc(look_at(array, 1, ""))
	valb = dynconv(val, valb)
	(val > valb)
end
def infeq(array)
	val = calc(look_at(array, 0, ""))
	valb = calc(look_at(array, 1, ""))
	valb = dynconv(val, valb)
	(val <= valb)
end
def supeq(array)
	val = calc(look_at(array, 0, ""))
	valb = calc(look_at(array, 1, ""))
	valb = dynconv(val, valb)
	(val >= valb)
end
def cust_true(array)
	true
end
def cust_false(array)
	false
end
