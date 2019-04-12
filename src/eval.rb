def eval(tokens)
  if tokens.length > 0
    fun = tokens[0].get.calc
    args = tokes[1..-1]
    args ||= []
    if fun.type?("fun")
      fun.call(args)
    else if $vars.get_value("cannot_call").type?("fun")
      $vars.get_value("cannot_call").call([fun] + args)
    else
      raise "Uncalllable function"
    end
  end
end
