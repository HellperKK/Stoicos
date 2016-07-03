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
class Valeur
	def initialize(x)
		@valeur = x
	end
	def calc
		self
	end
end
class Entier < Valeur
	#Contient un int
	def to_int
		@valeur
	end
	def to_float
		@valeur.to_f
	end
	def to_string
		@valeur.to_s
	end
	def to_var
		@valeur.to_s
	end
	def to_bool
		@valeur != 0
	end
	def to_proce
		[@valeur]
	end
	def to_array
		[@valeur]
	end
end
class Flottant < Valeur
	#Contient un float
	def to_int
		@valeur.to_i
	end
	def to_float
		@valeur
	end
	def to_string
		@valeur.to_s
	end
	def to_var
		@valeur.to_s
	end
	def to_bool
		@valeur != 0.0
	end
	def to_proce
		[@valeur]
	end
	def to_array
		[@valeur]
	end
end
class Chaine < Valeur
	#Contient une string
	def to_int
		@valeur.to_i
	end
	def to_float
		@valeur.to_f
	end
	def to_string
		@valeur
	end
	def to_var
		@valeur.split(" ")[0]
	end
	def to_bool
		@valeur != ""
	end
	def to_proce
		[@valeur]
	end
	def to_array
		[@valeur]
	end
end
class Variable < Valeur
	#Contient une string
	def to_int
		$variables.get_value(@valeur).to_int
	end
	def to_float
		$variables.get_value(@valeur).to_float
	end
	def to_string
		$variables.get_value(@valeur).to_string
	end
	def to_var
		@valeur
	end
	def to_bool
		$variables.get_value(@valeur).to_bool
	end
	def to_proce
		$variables.get_value(@valeur).to_proce
	end
	def to_array
		$variables.get_value(@valeur).to_array
	end
end
class Booleen < Valeur
	#Contient un booleen
	def to_int
		@valeur ? 1 : 0
	end
	def to_float
		@valeur ? 1.0 : 0.0
	end
	def to_string
		@valeur ? "true" : "false"
	end
	def to_var
		@valeur ? "true" : "false"
	end
	def to_bool
		@valeur
	end
	def to_proce
		[@valeur]
	end
	def to_array
		[@valeur]
	end
end
class Procedure < Valeur
	#Contient un array
	def to_int
		@valeur != [] ? @valeur[0].to_int : 0
	end
	def to_float
		@valeur != [] ? @valeur[0].to_float : 0.0
	end
	def to_string
		@valeur != [] ? @valeur[0].to_string : ""
	end
	def to_var
		@valeur != [] ? @valeur[0].to_var : ""
	end
	def to_bool
		@valeur != [] ? @valeur[0].to_bool : false
	end
	def to_proce
		@valeur
	end
	def to_array
		@valeur
	end
	def calc
		chercheFonc(@valeur)
	end
end
class Tableau < Valeur
	#Contient un array
	def to_int
		@valeur != [] ? @valeur[0].to_int : 0
	end
	def to_int
		@valeur != [] ? @valeur[0].to_int : 0
	end
	def to_string
		@valeur != [] ? @valeur[0].to_string : ""
	end
	def to_var
		@valeur != [] ? @valeur[0].to_var : ""
	end
	def to_bool
		@valeur != [] ? @valeur[0].to_bool : false
	end
	def to_proce
		@valeur != [] ? @valeur[0].to_proce : ""
	end
	def to_array
		@valeur
	end
end
def to_objet(chaine, id)
	if chaine.to_i.to_s == chaine
		Entier.new(chaine.to_i)
	elsif chaine.to_i.to_s == chaine
		Flottant.new(chaine.to_f)
	elsif chaine[0] == '"'
		Chaine.new(chaine[1..-2])
	elsif chaine[0] == '('
		Procedure.new(parseur(chaine[1..-2]))
	elsif ["true", "false"].include?(chaine)
		Booleen.new(chaine == "true")
	elsif id == 0
		chaine
	else
		Variable.new(chaine)
	end
end