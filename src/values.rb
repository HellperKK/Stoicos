class Value
	attr_reader :value, :type
	def initialize(type, value)
		@type = type
		@value = value
	end
	def total_manip(type)
		self.get.calc.convert(type)
	end
	def type?(type)
		@type == type
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

class Ident < Value
	def get
		# puts @value
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
				raise "Inextistant attribute #{@attr} in #{@value}"
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

class CustomFunction < Value
	def initialize(type, value, args)
		super(type, value)
		@args = args
	end
	def call(values)
		$vars.add_stack
		if values.length == @args.length
			@args.zip(arguments){|pair| $vars.set_value(pair[0].value, pair[1].get.calc)}
			#~ puts $vars
			result = @value.calculate
			#~ puts $vars
			$vars.remove_stack
			result
		else
			raise "bad argument number (#{values.length} instead of #{@args.length})"
		end
	end
end

class ArrayFunction < Value
	def initialize(type, value)
		super(type, value)
	end
	def call(args)
		$vars.add_stack
		$vars.set_value("args", Value.new("array", args))
		result = @value.calculate
		$vars.remove_stack
		result
	end
end

class Proce < Value
	def initialize(type, value)
		super(type, value)
	end
	def calc
		eval(@value)
	end
	def calculate
		eval(@value)
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

=begin
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
=end
