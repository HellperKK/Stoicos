class Variable
	attr_reader :value
	def initialize(value, cons)
		@value = value
		@cons = cons
		@type = "dynamic"
	end
	def set_value(value)
		raise "Illegal constant set" if @cons
		value = value.convert(@type) unless @type == "dynamic"
		@value = value
	end
end
