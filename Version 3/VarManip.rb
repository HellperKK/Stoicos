class Vars
	attr_reader :vars
	def initialize
		@vars = [self.initial_hash]
	end
	
	def initial_hash
		Hash.new()
	end
	
	def to_s
		@vars.to_s
	end
	
	def add(nom, contenu)
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
		self.get_value("unit")
	end
	
	def add_stack
		@vars << self.initial_hash
	end
	
	def remove_stack
		@vars.pop
	end
end