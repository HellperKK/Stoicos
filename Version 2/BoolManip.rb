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
	bool = array.fetch(0, Vide.new(nil)).calc.to_bool
	Booleen.new(! bool)
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
def inf(array)
	val = array.fetch(0, Vide.new(nil)).calc.get
	valb = array.fetch(1, Vide.new(nil)).calc.get
	valb = val.to_self(valb)
	Booleen.new(val.valeur < valb)
end
def sup(array)
	val = array.fetch(0, Vide.new(nil)).calc.get
	valb = array.fetch(1, Vide.new(nil)).calc.get
	valb = val.to_self(valb)
	Booleen.new(val.valeur > valb)
end
def infeq(array)
	val = array.fetch(0, Vide.new(nil)).calc.get
	valb = array.fetch(1, Vide.new(nil)).calc.get
	valb = val.to_self(valb)
	Booleen.new(val.valeur <= valb)
end
def supeq(array)
	val = array.fetch(0, Vide.new(nil)).calc.get
	valb = array.fetch(1, Vide.new(nil)).calc.get
	valb = val.to_self(valb)
	Booleen.new(val.valeur >= valb)
end
#~ def cust_true(array)
	#~ true
#~ end
#~ def cust_false(array)
	#~ false
#~ end
