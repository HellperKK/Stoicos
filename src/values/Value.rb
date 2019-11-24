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
		self
		# if @type == type
		# 	self
		# elsif ! ($types.include?(@type))
		# 	puts [self, @type, type].to_s
		# 	self
		# elsif ! ($types[@type].conversion.include?(type))
		# 	$types[type].defaut.call()
		# else
		# 	$types[@type].conversion[type].call(self)
		# end
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
