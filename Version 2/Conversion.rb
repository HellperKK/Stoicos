=begin
Liste des types
Int
String
Proc
Variable
Boolean
Array
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