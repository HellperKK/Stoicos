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
$types = {}

class Value
	attr_reader :value
	def initialize(type, value)
		@type = type
		@value = value
	end
	def convert(type)
		if @type == type
			self
		elsif ! ($types.include?(@type))
			puts [self, @type, type].to_s
		elsif ! ($types[@type].conversion.include?(type))
			$types[@type].defaut.call()
		else
			$types[@type].conversion[type].call(@value)
		end
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
	def call(x)
		self
	end
end

class Variable < Value
	def initialize(type, name)
		@type = type
		@name = name
	end
	def get
		$vars.get_value(@name)
	end
end

class NativeFunction < Value
	def initialize(type, lambda)
		@type = type
		@lam = lambda
	end
	def call(value)
		@lam.call(value)
	end
end

class CustonFunction < Value
	def initialize(type, code)
		@type = type
		@code = code
	end
	def call(value)
		@code.calculate
	end
end

class Type
	attr_reader :conversion, :defaut
	def initialize(defaut=lambda{$vars.get_value("unit")})
		@conversion = Hash.new()
		@defaut = defaut
	end
end

def to_objet(chaine)
	if chaine.to_i.to_s == chaine
		Value.new("int", chaine.to_i)
	elsif chaine.to_f.to_s == chaine
		Value.new("float", chaine.to_f)
	elsif chaine[0] == '"'
		Value.new("string", chaine[1..-2])
	elsif chaine[0] == '('
		Value.new("proc", parseur(chaine[1..-2]))
	elsif chaine[0] == '{'
		Value.new("block", parseur(chaine[1..-2]))
	elsif ["true", "false"].include?(chaine)
		Value.new("bool", chaine == "true")
	else
		Variable.new("nom", chaine)
	end
end