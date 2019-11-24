class LexRule
  def initialize(reg, lam)
    @reg = reg
    @lam = lam
    @result = nil
  end

  def match?(string)
    @result = @reg.match(string)
    # There is a result and the whole match starts at 0
    (@result != nil) && (@result.offset(0)[0] == 0)
  end

  def capture_length
    @result != nil ? @result[0].length : 0
  end

  def capture
    # puts [self].to_s
    @lam.call(*@result.captures)
  end
end
