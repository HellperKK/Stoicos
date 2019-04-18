class Vars
	attr_reader :vars
	def initialize
		@vars = [self.initial_hash]
	end

	def unit
		Value.new("unit", nil)
	end

	def initial_hash
		Hash.new
	end

	def to_s
		@vars.to_s
	end

	def set_variable(nom, contenu)
		dict = @vars[-1]
		if dict.include?(nom)
			dict[nom].set_value(contenu)
		else
			dict[nom] = Variable.new(contenu, false)
		end
		contenu
	end

	def set_constant(nom, contenu)
		dict = @vars[-1]
		if dict.include?(nom)
			dict[nom].set_value(contenu)
		else
			dict[nom] = Variable.new(contenu, true)
		end
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
				return @vars[i][nom].value
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
	attr_reader :value
	def initialize(value, cons)
		@value = value
		@cons = cons
	end
	def set_value(value)
		raise "Illegal constant set" if @cons
		@value = value
	end
end
