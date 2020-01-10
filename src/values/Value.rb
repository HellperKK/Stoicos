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

	def matchCall?(args)
		false
	end

	def hash
		@value.hash
	end
end
