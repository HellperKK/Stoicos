def allocate_var(array)
	nom = str(calc(look_at(array, 0, "")))
	donnee = calc(look_at(array, 1, ""))
	$variables[nom] = donnee
	""
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
