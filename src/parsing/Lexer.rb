class Lexer
	def initialize
		@rules = []
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
				tokens << rule.capture if rule.capture
				len = rule.capture_length
				string = string[len..-1]
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

$lexer.add_rule(/^\[/) do ||
	Token.new("OpenBra")
end

$lexer.add_rule(/^\]/) do ||
	Token.new("CloseBra")
end

$lexer.add_rule(/^\{/) do ||
	Token.new("OpenCurly")
end

$lexer.add_rule(/^\}/) do ||
	Token.new("CloseCurly")
end

$lexer.add_rule(/^:/) do ||
	Token.new("Colon")
end

$lexer.add_rule(/^\./) do ||
	Token.new("Dot")
end

$lexer.add_rule(/^#/) do ||
	Token.new("Hash")
end

$lexer.add_rule(/^@/) do ||
	Token.new("Arobase")
end

$lexer.add_rule(/^("(\\"|[^"])*")/) do |str|
	Token.new("String", str[1...-1])
end

$lexer.add_rule(/^([0-9]+(\.[0-9]*)?)/) do |ident|
	Token.new("Number", ident)
end

$lexer.add_rule(/^([A-Za-z0-9\+\*\/\-%_&\|=<>!]+)/) do |ident|
	Token.new("Identifier", ident)
end

$lexer.add_rule(/^;.*\n/) do ||
	nil
end

$lexer.add_rule(/^\s+/) do ||
	nil
end
