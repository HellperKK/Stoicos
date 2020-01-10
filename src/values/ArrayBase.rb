class ArrayBase < Value
  def get
    Value.new("array", @value.map{|i| i.get.calc})
  end
end
