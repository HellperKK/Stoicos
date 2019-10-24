class LexRule
  attr_reader :result

  def initialize(reg, lam)
    @reg = reg
    @lam = lam
    @result = nil
  end

  def match?(string)
    @result = @reg.match(string)
    @result != nil
  end

  def capture_length
    @result != nil ? @result[0].length : 0
  end

  def capture
    @lam.call(*@result.captures)
  end
end
