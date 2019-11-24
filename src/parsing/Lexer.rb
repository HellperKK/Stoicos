class Lexer
	def initialize
		@rules = []
		add_rule(/;.*/) do ||
			nil
		end

		add_rule(/\(([^()]*\g<0>*[^()]*)\)/) do |code|
			toks = Lexer.new.lex(code.strip)
			FunCall.new("FunCall", toks)
		end

		# $lexer.add_rule(/^([A-Za-z0-9\+\*\/\-%_&\|=<>!]*\[[^\[\]]*\g<0>*[^\[\]]*\])/) do ||
		# 	Token.new("ArrayAcces")
		# end

		add_rule(/^"((\\"|[^"])*)"/) do |str|
			Value.new("String", str)
		end

		# $lexer.add_rule(/^([0-9]+(\.[0-9]*)?)/) do |ident|
		# 	Token.new("Number", ident)
		# end

		add_rule(/([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)/) do |ident|
			Ident.new("Identifier", ident)
		end

		add_rule(/^\s+/) do ||
			nil
		end
	end

	def add_rule(reg)
		@rules << LexRule.new(reg, lambda{|*val| yield(*val)})
	end

	def lex(string)
		tokens = []
		while string != ""
			rule_ind = @rules.index do |r|
				r.match?(string)
			end

			if rule_ind != nil
				rule = @rules[rule_ind]
				capture = rule.capture
				tokens << capture if capture
				len = rule.capture_length
				string = string[len..-1]
			else
				raise "No rule found for #{string[0..10]}"
			end
		end

		tokens
	end
end
