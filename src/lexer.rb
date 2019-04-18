def find_second(text, char)
	index = 1
	while index < text.length
		if text[index] == char
			return index
		end
		index += 1
	end
	raise "missing #{char}"
end

def find_next_match(text, reg)
	index = 1
	#puts text
	while index < text.length
		if reg.match?(text[index])
			return index
		end
		index += 1
	end
	raise "outRange"
end

def find_matching(text, char, charbis, index=1, compteur=1)
	if compteur == 0
		index - 1
	elsif text[index] == char
		find_matching(text, char, charbis, index+1, compteur-1)
	elsif text[index] == charbis
		find_matching(text, char, charbis, index+1, compteur+1)
	elsif index == text.length
		raise "missing #{char}"
	else
		find_matching(text, char, charbis, index+1, compteur)
	end
end

def clean(texte)
	lines = texte.split("\n")
	lines.length.-(1).downto(0) do |index|
		if lines[index].strip[0] == ";"
			lines.delete_at(index)
		end
	end
	lines.join("\n")
end

def to_token(chaine, line_num)
	if /^\d+$/.match?(chaine)
		Value.new("int", chaine.to_i)
	elsif /^\d+\.\d+$/.match?(chaine)
		Value.new("float", chaine.to_f)
	elsif chaine[0] == '"'
		Value.new("string", chaine[1..-2])
	elsif chaine[0] == '['
		ArrayParse.new("array_parse", lex(chaine[1..-2], line_num))
	elsif chaine[0] == '('
		Proce.new("proc", lex(chaine[1..-2], line_num))
	elsif chaine[0] == '{'
		Blocke.new("block", lex(chaine[1..-2], line_num))
	elsif /^:[A-Za-z0-9\+\*\/\-%_&\|=<>\.!]+$/.match?(chaine)
		Value.new("symbol", chaine[1..-1])
	elsif ["true", "false"].include?(chaine)
		Value.new("bool", chaine == "true")
	elsif /^[A-Za-z0-9\+\*\/\-%_&\|=<>\.!]+$/.match?(chaine)
		Ident.new("nom", chaine)
	else
		raise "uknown token --> #{chaine}"
	end
end


def lex(texte, line_num=1)
  cleaned = clean(texte)
	tokens = []
	while cleaned != ""
		begin
			if cleaned[0] == '"'
				point = find_second(cleaned, '"')
			elsif cleaned[0] == "("
				point = find_matching(cleaned, ")", "(")
			elsif cleaned[0] == "["
				point = find_matching(cleaned, "]", "[")
			elsif cleaned[0] == "{"
				point = find_matching(cleaned, "}", "{")
			elsif /\s/.match(cleaned[0])
				line_num += 1 if cleaned[0] == "\n"
				cleaned = cleaned[1..-1]
				next
			elsif ! /\s/.match(cleaned)
				tokens.push(to_token(cleaned, line_num))
				break
			else
				point = find_next_match(cleaned, /\s/) - 1
			end
			elem = cleaned[0..point]
			line_num += elem.count("\n")
			tokens.push(to_token(elem.strip, line_num))
			cleaned = cleaned[(point + 1)..-1]
		rescue => error
			# puts error.message
			# puts error.backtrace
			puts error.message + " on line " + line_num.to_s
			exit
		end
	end
	tokens
end
