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
def intbis(array)
	int(calc(look_at(array, 0, 0)))
end
def arr(arg)
=begin
	if arg[0] == "["
		arg = arg[1..-2].gsub("[", "").gsub("]", "").split(",")
		arg.each{|i| i.strip!}
	end
=end
	begin
		argbis = arg.to_a
	rescue
		argbis = [arg]
	end
	argbis.map{|i| calc(i)}
end
def arrbis(arg)
=begin
	if arg[0] == "["
		arg = arg[1..-2].gsub("[", "").gsub("]", "").split(",")
		arg.each{|i| i.strip!}
	end
=end
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
def dynconv(arg, argbis)
	if arg.is_a?(Integer)
		int(argbis)
	elsif arg.is_a?(Array)
		arr(argbis)
	elsif arg.is_a?(String)
		str(argbis)
	else
		bool(argbis)
	end
end
def lamb(args)
	
end