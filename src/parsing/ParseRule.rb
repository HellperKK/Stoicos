class ParseRule
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
    @result != nil ? @result[0].split("_").length : 0
  end

  def capture
    @lam.call(*@result.captures)
  end
end
