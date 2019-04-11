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

def lex(texte)
  cleaned = clean(texte)
	tokens = []
	line_num = 1
	puts "test"
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
				tokens.push(cleaned)
				break
			else
				point = find_next_match(cleaned, /\s/) - 1
			end
			elem = cleaned[0..point]
			line_num += elem.count("\n")
			tokens.push(elem.strip)
			cleaned = cleaned[(point + 1)..-1]
			# tokens << to_objet(line[0..point])
			# to_objet(line[0..point]) + parseur(line[(point + 1)..-1])
		rescue => error
			puts error.message + " on line " + line_num.to_s
			exit
		end
	end
	puts tokens.to_s
end
