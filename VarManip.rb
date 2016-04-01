class Vars
	def initialize
		@vars = Hash.new([""])
	end
	def add(nom, contenu)
		@vars[nom] = [contenu] + @vars[nom]
		@vars[nom][0]
	end
	def delete(nom)
		a = @vars[nom][0]
		@vars[nom].delete_at(0)
		a
	end
	def swap(nom, nombis)
		@vars[nom][0], @vars[nombis][0] = @vars[nombis][0], @vars[nom][0]
		@vars[nom][0]
	end
	def get_value(nom)
		@vars[nom][0]
	end
	def history(nom)
		@vars[nom]
	end
end

def allocate_var(array)
	nom = str(calc(look_at(array, 0, "")))
	donnee = calc(look_at(array, 1, ""))
	$variables.add(nom, donnee)
	#puts "|#{$variables[nom]}|"
	donnee
end
def read_var(array)
	nom = str(calc(look_at(array, 0, "")))
	$variables.get_value(nom)
end
def swap_var(array)
	nom = str(calc(look_at(array, 0, "")))
	nombis = str(calc(look_at(array, 1, "")))
	$variables.swap(nom, nombis)
end
def let_in(array)
	nom = str(calc(look_at(array, 0, "")))
	action = look_at(array, 1, "")
	actionbis = look_at(array, 2, "")
	#puts "#{nom}, #{action}, #{actionbis}"
	$variables.add(calc(action))
	#puts $variables[nom]
	a = calc(actionbis)
	$variables.delete(nom)
	a
end
def increment(array)
	nom = str(calc(look_at(array, 0, "")))
	$variables.add(nom, int($variables.get_value(nom)) + 1)
	$variables.get_value(nom)
end
def decrement(array)
	nom = str(calc(look_at(array, 0, "")))
	$variables.add(nom, int($variables.get_value(nom)) - 1)
	$variables.get_value(nom)
end