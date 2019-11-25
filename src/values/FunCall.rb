class FunCall < Value
  def calc
    if @value.length > 0
      fun = @value[0].get.calc
      args = @value[1..-1].map{|el| el.get.calc}
      args ||= []
      fun.call(args)
    else
      raise "Absent function"
    end
  end
end
