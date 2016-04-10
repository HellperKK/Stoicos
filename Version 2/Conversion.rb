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
Struct
=end
def keep_only(str, strbis)
	if str == ""
		""
	else
		a = str[0]
		b = str[1..-1]
		if strbis.include?(a)
			a + keep_only(b, strbis)
		else
			keep_only(b, strbis)
		end
	end
end
class Entier
	def initialize(x)
		@valeur = x
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
		@valeur.split(" ")[0]
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
		@valeur.split(" ")[0]
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
class Booleen
	def initialize(x)
		@valeur = x
	end
	def to_int
		@valeur ? 1 : 0
	end
	def to_string
		@valeur ? "true" : "false"
	end
	def to_proce
		@valeur ? "true" : "false"
	end
	def to_var
		@valeur ? "true" : "false"
	end
	def to_bool
		@valeur
	end
	def to_array
		[@valeur]
	end
end
class Tableau
	def initialize(x)
		@valeur = x
	end
	def to_int
		@valeur != [] ? @valeur[0].to_int : 0
	end
	def to_string
		@valeur != [] ? @valeur[0].to_string : ""
	end
	def to_proce
		@valeur != [] ? @valeur[0].to_proce : ""
	end
	def to_var
		@valeur != [] ? @valeur[0].to_var : ""
	end
	def to_bool
		@valeur != [] ? @valeur[0].to_bool : false
	end
	def to_array
		@valeur
	end
end
def to_objet(chaine)
	if chaine == keep_only(chaine, "0123456789")
		Entier.new(chaine.to_i)
	elsif chaine[0] == '"'
		Chaine.new(chaine[1..-2])
	elsif chaine[0] == '('
		Procedure.new(chaine[1..-2])
	elsif ["true", "false"].include?(chaine)
		Booleen.new(chaine == "true")
	else
		Variable.new(chaine)
	end
end