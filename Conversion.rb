def str(arg)
	begin
		argbis = arg.to_s
	rescue
		argbis = ""
	end
	if argbis[0] == "'"
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
def lamb(args)
	
end
