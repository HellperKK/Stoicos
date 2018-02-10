def look_at(array, indice)
	if indice <= (array.length-1)
		array[indice]
	else
		$vars.unit
	end
end
$vars = Vars.new
