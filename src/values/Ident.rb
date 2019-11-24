class Ident < Value
  def get
    VariableManager.vars.get_value(@value)
  end
end
