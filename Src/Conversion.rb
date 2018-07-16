=begin
Liste des types :
Int -> present
Float -> present
String -> present
Variable -> present
Boolean -> present
Proc -> present
Bloc -> present
Array -> present
Unit -> present
Char
Fonction -> present
Struct -> present
=end
$types = {}

class Value
	attr_reader :value, :type
	def initialize(type, value)
		@type = type
		@value = value
	end
	def total_manip(type)
		self.get.calc.convert(type)
	end
	def convert(type)
		if @type == type
			self
		elsif ! ($types.include?(@type))
			puts [self, @type, type].to_s
			self
		elsif ! ($types[@type].conversion.include?(type))
			$types[type].defaut.call()
		else
			$types[@type].conversion[type].call(self)
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
	def to_s
		@value.to_s
	end
end

class Variable < Value
	def initialize(type, value)
		super(type, value)
	end
	def get
		$vars.get_value(@value)
	end
end

class NSpace < Value
	def initialize(type, value, attr)
		super(type, value)
		@attr = attr
	end
	def get
		begin
			temp = $vars.get_value(@value).value
			if temp.include?(@attr)
				temp[@attr]
			else
				$vars.unit
			end
		rescue
			$vars.get_value(@value)
		end
	end
end

class NativeFunction < Value
	def initialize(type, value)
		super(type, value)
	end
	def call(value)
		@value.call(value)
	end
end

class CustonFunction < Value
	def initialize(type, value, args)
		super(type, value)
		@args = args
	end
	def call(value)
		$vars.add_stack
		if value.length < @args.length
			arguments = value + Array.new(@args.length - value.length, $vars.unit)
		else
			arguments = value[0...@args.length]
		end
		@args.zip(arguments){|pair| $vars.set_value(pair[0].value, pair[1].get.calc)}
		#~ puts $vars
		result = @value.calculate
		#~ puts $vars
		$vars.remove_stack
		result
	end
end

class ArrayFunction < Value
	def initialize(type, value)
		super(type, value)
	end
	def call(args)
		$vars.add_stack
		$vars.set_value("args", args)
		#~ puts $vars
		result = @value.calculate
		#~ puts $vars
		$vars.remove_stack
		result
	end
end

class Proce < Value
	def initialize(type, value)
		super(type, value)
	end
	def calc
		chercheFonc(@value)
	end
	def calculate
		chercheFonc(@value)
	end
end

class Blocke < Value
	def initialize(type, value)
		super(type, value)
	end
	def calculate
		a = $vars.unit
		@value.each{|x| a = x.get.calc}
		a
	end
end

class ArrayParse < Value
	def initialize(type, value)
		super(type, value)
	end
	def calc
		Value.new("array", @value.map{|i| i.get.calc})
	end
end

class Type
	attr_reader :conversion, :defaut
	def initialize(defaut=lambda{$vars.unit})
		@conversion = Hash.new()
		@defaut = defaut
	end
	def set_conv(type, lam)
		@conversion[type] = lam
	end
end

def to_objet(chaine)
	if chaine.to_i.to_s == chaine
		Value.new("int", chaine.to_i)
	elsif chaine.to_f.to_s == chaine
		Value.new("float", chaine.to_f)
	elsif chaine[0] == '"'
		Value.new("string", chaine[1..-2])
	elsif chaine[0] == '['
		ArrayParse.new("array_parse", parseur(chaine[1..-2]))
		# Value.new("array", parseur(chaine[1..-2]).map{|i| i.get.calc})
	elsif chaine[0] == '('
		Proce.new("proc", parseur(chaine[1..-2]))
	elsif chaine[0] == '{'
		Blocke.new("block", parseur(chaine[1..-2]))
	elsif chaine[0] == ':'
		Value.new("symbol", chaine[1..-1])
	elsif chaine[0] == '!'
		to_objet(chaine[1..-1]).calc.get
	elsif ["true", "false"].include?(chaine)
		Value.new("bool", chaine == "true")
	elsif chaine.split(".").length >= 2
		vals = chaine.split(".")
		NSpace.new("nom", vals[0], vals[1])
	else
		Variable.new("nom", chaine)
	end
end
