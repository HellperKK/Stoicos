class Vars
	def initialize
		@vars = Hash.new([""])
	end
	def to_s
		@vars.to_s
	end
	def add(nom, contenu)
		@vars[nom] = [contenu] + @vars[nom]
		@vars[nom][0]
	end
	def delete(nom)
		a = @vars[nom][0]
		if @vars[nom].length > 2
			@vars[nom].delete_at(0)
		else
			@vars.delete(nom)
		end
		a
	end
	def replace(nom, contenu)
		if @vars[nom] != [""] 
			@vars[nom][0] = contenu
		else
			@vars[nom] = [contenu] + @vars[nom]
		end
		contenu
	end
	def swap(nom, nombis)
		@vars[nom][0], @vars[nombis][0] = @vars[nombis][0], @vars[nom][0]
		[@vars[nom][0], @vars[nombis][0]]
	end
	def get_value(nom)
		@vars[nom][0]
	end
	def history(nom)
		@vars[nom]
	end
	def update
		@vars.each do |key, value|
			puts key
			puts value
			if value == [""]
				@var.delete(key)
			end
		end
	end
end

def allocate_var(array)
	nom = str(calc(look_at(array, 0, "")))
	donnee = calc(look_at(array, 1, ""))
	$variables.add(nom, donnee)
	donnee
end
def replace_var(array)
	nom = str(calc(look_at(array, 0, "")))
	donnee = calc(look_at(array, 1, ""))
	$variables.replace(nom, donnee)
	donnee
end
def read_var(array)
	nom = str(calc(look_at(array, 0, "")))
	$variables.get_value(nom)
end
def get_historic(array)
	nom = str(calc(look_at(array, 0, "")))
	$variables.history(nom)
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
	$variables.add(nom, calc(action))
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