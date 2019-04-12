class Vars
	attr_reader :vars
	def initialize
		@vars = [self.initial_hash]
	end

	def unit
		Value.new(0, "unit", nil)
	end

	def initial_hash
		Hash.new(self.unit)
	end

	def to_s
		@vars.to_s
	end

	def set_value(nom, contenu)
		@vars[-1][nom] = contenu
		contenu
	end

	def delete(nom)
		a = @vars[nom]
		@vars[-1].delete(nom)
	end

	def get_value(nom)
		long = @vars.length - 1
		long.downto(0) do |i|
			if @vars[i].include?(nom)
				return @vars[i][nom]
			end
		end
		self.unit
	end

	def add_stack
		@vars << self.initial_hash
	end

	def get_stack
		@vars[-1]
	end

	def remove_stack
		@vars.pop
	end
	def to_s
		@vars[-1].to_s
	end
end

class Variable

end
