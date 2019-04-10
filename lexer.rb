def find_second(text, char, index=1)
	if index == text.length
		raise "outRange"
	elsif text[index] == char
		index
	else
		find_second(text, char, index+1)
	end
end

def find_matching(text, char, charbis, index=1, compteur=1)
	if compteur == 0
		index - 1
	elsif text[index] == char
		find_matching(text, char, charbis, index+1, compteur-1)
	elsif text[index] == charbis
		find_matching(text, char, charbis, index+1, compteur+1)
	elsif index == text.length
		raise "outRange"
	else
		find_matching(text, char, charbis, index+1, compteur)
	end
end

def lex(texte)

end
