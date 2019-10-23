class Lexer
	def initialize
		@rules = Hash.new
		@tokens = []
		@pos = 0
	end

	def add_rule(reg)
		@rules[reg] = lambda{|val| yield(val)}
	end
end
