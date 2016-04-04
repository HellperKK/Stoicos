def allocate_var(array)
	nom = str(calc(look_at(array, 0, "")))
	donnee = calc(look_at(array, 1, ""))
	$variables[nom] = donnee
	#puts "|#{$variables[nom]}|"
	donnee
end
def read_var(array)
	nom = str(calc(look_at(array, 0, "")))
	$variables[nom]
end
def swap_var(array)
	nom = str(calc(look_at(array, 0, "")))
	nombis = str(calc(look_at(array, 1, "")))
	$variables[nom], $variables[nombis] = $variables[nombis], $variables[nom]
	""
end
def let_in(array)
	nom = str(calc(look_at(array, 0, "")))
	action = look_at(array, 1, "")
	actionbis = look_at(array, 2, "")
	#puts "#{nom}, #{action}, #{actionbis}"
	$variables[nom] = calc(action)
	#puts $variables[nom]
	a = calc(actionbis)
	$variables.delete(nom)
	a
end
def increment(array)
	nom = str(calc(look_at(array, 0, "")))
	$variables[nom] = int($variables[nom]) + 1
	$variables[nom]
end
def decrement(array)
	nom = str(calc(look_at(array, 0, "")))
	$variables[nom] = int($variables[nom]) - 1
	$variables[nom]
end