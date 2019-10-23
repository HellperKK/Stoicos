class Lexer
	def initialize
		@rules = []
		@pos = 0
	end

	def add_rule(reg)
		@rules << ParseRule.new(reg, lambda{|*val| yield(*val)})
	end

	def lex(string)
		tokens = []
		while string != ""

			rule_ind = @rules.rindex do |r|
				r.match?(string)
			end

			if rule_ind != nil
				rule = @rules[rule_ind]
				tokens << rule.capture if rule.capture
				length = rule.capture_length
				string = string[length..-1]
				puts string
				puts "________"
			else
				raise "No rule found for #{string[0..10]}"
			end
		end

		tokens
	end
end

$lexer = Lexer.new

$lexer.add_rule(/^\(/) do ||
	Token.new("OpenPar")
end

$lexer.add_rule(/^\)/) do ||
	Token.new("ClosePar")
end

$lexer.add_rule(/^("(\\"|[^"])*")/) do |str|
	Token.new("String", str[1...-1])
end

$lexer.add_rule(/^([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)/) do |ident|
	Token.new("Identifier", ident)
end

$lexer.add_rule(/^\s+/) do |ident|
	nil
end
