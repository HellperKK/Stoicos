class Value
	attr_reader :value, :type
	def initialize(line_num, type, value)
		@type = type
		@value = value
		@line_num = line_num
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

class Variable < Value
	def get
		# puts @value
		$vars.get_value(@value)
	end
end

class NSpace < Value
	def initialize(line_num, type, value, attr)
		super(line_num, type, value)
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
	def initialize(line_num, type, value)
		super(line_num, type, value)
	end
	def call(value)
		@value.call(value)
	end
end

class CustonFunction < Value
	def initialize(line_num, type, value, args)
		super(line_num, type, value)
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
	def initialize(line_num, type, value)
		super(line_num, type, value)
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
	def initialize(line_num, type, value)
		super(line_num, type, value)
	end
	def calc
		chercheFonc(@value)
	end
	def calculate
		chercheFonc(@value)
	end
end

class Blocke < Value
	def initialize(line_num, type, value)
		super(type, value)
	end
	def calculate
		a = $vars.unit
		@value.each{|x| a = x.get.calc}
		a
	end
end

class ArrayParse < Value
	def initialize(line_num, type, value)
		super(line_num, type, value)
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
