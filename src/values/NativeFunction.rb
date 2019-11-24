class NativeFunction
  class << self
    def make(lambda)
      Function.new("fun", NativeFunction.new(lambda))
    end
  end

  def initialize(lambda)
    @lambda = lambda
  end

  def call(args)
    @lambda.call(args)
  end
end
