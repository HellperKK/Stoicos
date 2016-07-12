class Vars
	attr_reader :vars
	def initialize
		@vars = Hash.new([Vide.new(nil)])
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
		if @vars[nom] != [Vide.new(nil)] 
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
end

def allocate_var(array)
	nom = array.fetch(0, Vide.new(nil)).calc.to_var
	donnee = array.fetch(1, Vide.new(nil)).calc
	if Vairable === donnee
		donnee = Chaine.new(donnee.valeur)
	end
	$variables.add(nom, donnee)
	donnee
end
def replace_var(array)
	nom = array.fetch(0, Vide.new(nil)).calc.to_var
	donnee = array.fetch(1, Vide.new(nil)).calc
	if Vairable === donnee
		donnee = Chaine.new(donnee.valeur)
	end
	$variables.replace(nom, donnee)
	donnee
end
def read_var(array)
	nom = array.fetch(0, Vide.new(nil)).calc.to_string
	$variables.get_value(nom)
end
def get_historic(array)
	nom = array.fetch(0, Vide.new(nil)).calc.to_var
	$variables.history(nom)
end
def swap_var(array)
	nom = array.fetch(0, Vide.new(nil)).calc.to_var
	nombis = array.fetch(1, Vide.new(nil)).calc.to_var
	$variables.swap(nom, nombis)
end
def let_in(array)
	nom = array.fetch(0, Vide.new(nil)).calc.to_var
	action = array.fetch(1, Vide.new(nil))
	if Vairable === action
		action = Chaine.new(action.valeur)
	end
	actionbis = array.fetch(2, Vide.new(nil))
	$variables.add(nom, action.calc)
	a = actionbis.calc
	$variables.delete(nom)
	a
end
def increment(array)
	nom = array.fetch(0, Vide.new(nil)).calc.to_var
	$variables.add(nom, $variables.get_value(nom).to_int + 1)
	$variables.get_value(nom)
end
def decrement(array)
	nom = array.fetch(0, Vide.new(nil)).calc.to_var
	$variables.add(nom, $variables.get_value(nom).to_int - 1)
	$variables.get_value(nom)
end