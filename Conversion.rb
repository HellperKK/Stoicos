def str(arg)
	argbis = arg.to_s
	if argbis[0] == '"'
		argbis[1..-2]
	else
		argbis
	end
end
def int(arg)
	arg = str(arg)
	arg.to_i
end
def arr(arg)
	if arg[0] == "["
		arg = arg[1..-2].gsub("[", "").gsub("]", "").split(",")
		arg.each{|i| i.strip!}
	end
	begin
		argbis = arg.to_a
	rescue
		argbis = [arg]
	end
	argbis.map!{|i| calc(i)}
	argbis
end
def arrbis(arg)
	if arg[0] == "["
		arg = arg[1..-2].gsub("[", "").gsub("]", "").split(",")
		arg.each{|i| i.strip!}
	end
	begin
		argbis = arg.to_a
	rescue
		argbis = [arg]
	end
	argbis
end
def bool(arg)
	if calc(arg)
		true
	else
		false
	end
end
def lamb(args)
	
end