=begin
Liste des types :
Int
String
Proc
Variable
Boolean
Array
Plus, potentiellement :
Float
Char
Fonction
=end
class Entier
	def initialize(x)
		@valeur = x.to_i
	end
	def to_int
		@valeur
	end
	def to_string
		@valeur.to_s
	end
	def to_proce
		@valeur.to_s
	end
	def to_var
		@valeur.to_s
	end
	def to_bool
		@valeur != 0
	end
	def to_array
		[@valeur]
	end
end
class Chaine
	def initialize(x)
		@valeur = x
	end
	def to_int
		@valeur.to_i
	end
	def to_string
		@valeur
	end
	def to_proce
		@valeur
	end
	def to_var
		@valeur
	end
	def to_bool
		@valeur != ""
	end
	def to_array
		[@valeur]
	end
end
class Procedure
	def initialize(x)
		@valeur = x
	end
	def to_int
		@valeur.to_i
	end
	def to_string
		@valeur
	end
	def to_proce
		@valeur
	end
	def to_var
		@valeur
	end
	def to_bool
		@valeur != ""
	end
	def to_array
		[@valeur]
	end
end
class Variable
	def initialize(x)
		@valeur = x
	end
	def to_int
		$variables.get_value(@valeur).to_int
	end
	def to_string
		$variables.get_value(@valeur).to_string
	end
	def to_proce
		$variables.get_value(@valeur).to_proce
	end
	def to_var
		@valeur
	end
	def to_bool
		$variables.get_value(@valeur).to_bool
	end
	def to_array
		$variables.get_value(@valeur).to_array
	end
end
class Tableau
	def initialize(x)
		@valeur = x.to_a
	end
	def to_int
		@valeur[0].to_int
	end
	def to_string
		@valeur[0].to_int
	end
	def to_proce
		@valeur[0].to_int
	end
	def to_var
		@valeur[0].to_int
	end
	def to_bool
		@valeur[0].to_int
	end
	def to_array
		@valeur[0].to_int
	end
end