class Parser
  def initialize
    @rules = []
  end

  def add_rule(rule)
		@rules << LexRule.new(reg, lambda{|*val| yield(*val)})
	end
end
