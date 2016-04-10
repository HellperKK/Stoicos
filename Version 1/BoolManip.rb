def cust_and(array)
	bool = bool(calc(look_at(array, 0, true)))
	boolb = bool(look_at(array, 1, true))
	bool && boolb
end
def cust_or(array)
	bool = bool(calc(look_at(array, 0, true)))
	boolb = bool(look_at(array, 1, true))
	bool || boolb
end
def cust_not(array)
	bool = bool(calc(look_at(array, 0, true)))
	not bool
end
def equal(array)
	val = calc(look_at(array, 0, ""))
	valb = calc(look_at(array, 1, ""))
	valb = dynconv(val, valb)
	(val == valb)
end
def different(array)
	val = calc(look_at(array, 0, ""))
	valb = calc(look_at(array, 1, ""))
	valb = dynconv(val, valb)
	(val != valb)
end
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
