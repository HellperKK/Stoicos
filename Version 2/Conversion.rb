=begin
Liste des types :
Int
Float
String
Variable
Boolean
Proc
Bloc
Array
Void
Plus, potentiellement :
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
	attr_reader :valeur
	def initialize(x)
		@valeur = x
	end
	def calc
		self
	end
	def calculate
		self
	end
	def get
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
	def to_char
		@valeur.to_s[0]
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
		[self]
	end
	def to_bloc
		[self]
	end
	def to_array
		[self]
	end
	def to_self(x) 
		x.to_int
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
	def to_char
		@valeur.to_s[0]
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
		[self]
	end
	def to_bloc
		[self]
	end
	def to_array
		[self]
	end
	def to_self(x) 
		x.to_float
	end
end
class Caractere < Valeur
	#Contient une string
	def to_int
		@valeur.to_i
	end
	def to_float
		@valeur.to_f
	end
	def to_char
		@valeur
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
		[self]
	end
	def to_bloc
		[self]
	end
	def to_array
		[self]
	end
	def to_self(x) 
		x.to_string
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
	def to_char
		@valeur[0]
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
		[self]
	end
	def to_bloc
		[self]
	end
	def to_array
		[self]
	end
	def to_self(x) 
		x.to_string
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
		$variables.get_value(@valeur).to_string[0]
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
	def to_proce
		$variables.get_value(@valeur).to_bloc
	end
	def to_array
		$variables.get_value(@valeur).to_array
	end
	def get 
		$variables.get_value(@valeur)
	end
	def to_self(x) 
		x.to_var
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
		@valeur ? "t" : "f"
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
		[self]
	end
	def to_bloc
		[self]
	end
	def to_array
		[self]
	end
	def to_self(x) 
		x.to_bool
	end
end
class Procedure < Valeur
	#Contient un array
	def to_int
		self.calculate.to_int
	end
	def to_float
		self.calculate.to_float
	end
	def to_string
		self.calculate.to_string[0]
	end
	def to_string
		self.calculate.to_string
	end
	def to_var
		self.calculate.to_var
	end
	def to_bool
		self.calculate.to_bool
	end
	def to_proce
		@valeur
	end
	def to_bloc
		@valeur
	end
	def to_array
		@valeur
	end
	def calc
		chercheFonc(@valeur)
	end
	def calculate
		chercheFonc(@valeur)
	end
	def to_self(x) 
		x.to_proce
	end
end
class Bloc < Valeur
	#Contient un array
	def to_int
		self.calculate.to_int
	end
	def to_float
		self.calculate.to_float
	end
	def to_string
		self.calculate.to_string[0]
	end
	def to_string
		self.calculate.to_string
	end
	def to_var
		self.calculate.to_var
	end
	def to_bool
		self.calculate.to_bool
	end
	def to_proce
		@valeur
	end
	def to_bloc
		@valeur
	end
	def to_array
		@valeur
	end
	def calculate
		a = Vide.new(nil)
		@valeur.each{|i| a = i.calc.get}
		a
	end
	def to_self(x) 
		x.to_bloc
	end
end
class Tableau < Valeur
	#Contient un array
	def to_int
		@valeur != [] ? @valeur[0].to_int : 0
	end
	def to_float
		@valeur != [] ? @valeur[0].to_float : 0.0
	end
	def to_var
		@valeur != [] ? @valeur[0].to_string[0] : ""
	end
	def to_string
		@valeur.map{|i| i.to_string}.to_s
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
	def to_bloc
		@valeur
	end
	def to_array
		@valeur
	end
	def to_self(x) 
		x.to_array
	end
end
class Vide < Valeur
	#Contient du vide
	def to_int
		0
	end
	def to_float
		0.0
	end
	def to_char
		""
	end
	def to_string
		""
	end
	def to_var
		""
	end
	def to_bool
		false
	end
	def to_proce
		[]
	end
	def to_bloc
		[]
	end
	def to_array
		[]
	end
	def to_self(x) 
		Vide.new(nil)
	end
end
def to_objet(chaine, id)
	if chaine.to_i.to_s == chaine
		Entier.new(chaine.to_i)
	elsif chaine.to_f.to_s == chaine
		Flottant.new(chaine.to_f)
	elsif chaine[0] == "'" 
		Caractere.new(chaine[1])
	elsif chaine[0] == '"'
		Chaine.new(chaine[1..-2])
	elsif chaine[0] == '('
		Procedure.new(parseur(chaine[1..-2]))
	elsif chaine[0] == '{'
		Bloc.new(parseur(chaine[1..-2]))
	elsif chaine[0] == '['
		Tableau.new(parseur(chaine[1..-2]).map{|i| i.calc})
	elsif ["true", "false"].include?(chaine)
		Booleen.new(chaine == "true")
	elsif id == 0
		chaine
	else
		Variable.new(chaine)
	end
end
#~ def to_objet_dyn(valeur)
	#~ if Integer === valeur 
		#~ Entier.new(valeur)
	#~ elsif Float === valeur
		#~ Flottant.new(valeur)
	#~ elsif String === valeur
		#~ Chaine.new(valeur)
	#~ elsif Array === valeur
		#~ Tableau.new(valeur)
	#~ elsif String === valeur
		#~ Chaine.new(valeur)
	#~ elsif TrueClass === valeur || FalseClass === valeur
		#~ Booleen.new(valeur)
	#~ end
#~ end