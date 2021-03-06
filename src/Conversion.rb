=begin
Liste des types :
Int -> present
Float -> present
String -> present
Synbole -> present
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
	def ==(other)
		if Value === other
			(self.type == other.type) && (self.value == other.value)
		else
			super(other)
		end
	end
	def eql?(other)
		self == other
	end
	def !=(other)
		if Value === other
			(self.type != other.type) || (self.value != other.value)
		else
			super(other)
		end
	end
	def hash
		@value.hash
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

class Access < Value
	def initialize(type, value, attr)
		super(type, value)
		@attr = attr
	end
	def get
		temp = $vars.get_value(@value).total_manip("array")
		key = @attr.total_manip("int").value
		look_at_value(temp, key)
	end
end

class Macroliser < Value
	def initialize(type, value)
		super(type, value)
	end
	def get
		to_objet(@value.total_manip("string").value).get
	end
end

class NSpace < Value
	def initialize(type, value, attr)
		super(type, value)
		@attr = attr
	end
	def get
		temp = $vars.get_value(@value)
		dig_at_value(temp, @attr)
	end
end

class MethodCall < Value
	def initialize(type, value, attr)
		super(type, value)
		@attr = attr
	end
	def get
		temp = $vars.get_value(@value)
		NativeFunction.new("fun", lambda do |array|
			look_at_value(temp, @attr).call([temp] + array)
		end)
	end
end

class CurriedFunction < Value
	def initialize(type, value)
		super(type, value)
	end
	def call(value)
		fun = $vars.get_value(@value)
		NativeFunction.new("fun", lambda do |array|
			fun.call(value + array)
		end)
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
		$vars.set_value("args", Value.new("array", args))
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
	def initialize(defaut)
		@conversion = Hash.new()
		@defaut = defaut
	end
	def set_conv(type, lam)
		@conversion[type] = lam
	end
end

def string_manage(str)
	return  eval %Q{"#{str}"}
	str.gsub(/\\"/, '"').gsub(/\\\\/, '\\')
end

def to_objet(chaine)
	if chaine.to_i.to_s == chaine
		Value.new("int", chaine.to_i)
	elsif chaine.to_f.to_s == chaine
		Value.new("float", chaine.to_f)
	elsif /^"(\\"|[^"])*"$/.match?(chaine)
		Value.new("string", string_manage(chaine[1..-2]))
	elsif chaine[0] == '"'
		Value.new("string", string_manage(chaine[1..-1]))
	elsif /^\[.*\]$/.match?(chaine)
		ArrayParse.new("array_parse", parseur(chaine[1..-2]))
	elsif chaine[0] == '['
		ArrayParse.new("array_parse", parseur(chaine[1..-1]))
		# Value.new("array", parseur(chaine[1..-2]).map{|i| i.get.calc})
	elsif /^\(.*\)$/.match?(chaine)
		Proce.new("proc", parseur(chaine[1..-2]))
	elsif chaine[0] == '('
		Proce.new("proc", parseur(chaine[1..-1]))
	elsif /^\{.*\}$/.match?(chaine)
		Blocke.new("block", parseur(chaine[1..-2]))
	elsif chaine[0] == '{'
		Blocke.new("block", parseur(chaine[1..-1]))
	elsif /^:[A-Za-z0-9\+\*\/\-%_&\|=<>!]+$/.match?(chaine)
		Value.new("symbol", chaine[1..-1])
	elsif chaine[0] == '@'
		nom = chaine[1..-1]
		if /^([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)\.([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)$/.match?(nom)
			vals = /^([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)\.([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)$/.match(nom)
			NSpace.new("nom", vals[1], vals[2]).get
		elsif /^([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)#([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)$/.match?(chaine)
			vals = /^([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)#([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)$/.match(chaine)
			MethodCall.new("nom", vals[1], vals[2]).get
		elsif /^[A-Za-z0-9\+\*\/\-%_&\|=<>!]+$/.match?(nom)
			Variable.new("nom", nom).get
		else
			$vars.unit
		end
	elsif /^([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)((\.([A-Za-z0-9\+\*\/\-%_&\|=<>!]+))+)$/.match?(chaine)
		vals = /^([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)((\.([A-Za-z0-9\+\*\/\-%_&\|=<>!]+))+)$/.match(chaine)
		NSpace.new("nom", vals[1], vals[2][1..-1].split("."))
	elsif /^([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)#([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)$/.match?(chaine)
		vals = /^([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)#([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)$/.match(chaine)
		MethodCall.new("nom", vals[1], vals[2])
	elsif /^#([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)$/.match?(chaine)
		vals = /^#([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)$/.match(chaine)
		CurriedFunction.new("fun", vals[1])
	elsif /^([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)\[(.+)\]$/.match?(chaine)
		capt = /^([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)\[(.+)\]$/.match(chaine)
		Access.new("nom", capt[1], to_objet(capt[2]))
	elsif /^[A-Za-z0-9\+\*\/\-%_&\|=<>!]+\.?$/.match?(chaine)
		Variable.new("nom", chaine)
	elsif /^\$(.+)$/.match?(chaine)
		Macroliser.new("nom", to_objet(/^\$(.+)$/.match(chaine)[1]))
	elsif /^\.([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)$/.match?(chaine)
		name = /^\.([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)$/.match(chaine)[1]
		NativeFunction.new("fun", lambda do |array|
			first = look_at(array, 0).total_manip("struct").value
			begin
				first[name]
			rescue
				first
			end
		end)
	else
		$vars.unit
	end
end
