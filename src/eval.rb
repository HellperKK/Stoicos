def eval(tokens)
  if tokens.length > 0
    fun = tokens[0].get.calc
    args = tokens[1..-1]
    args ||= []
    fun.call(args)
  else
    raise "Absent function"
  end
end
