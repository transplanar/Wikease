# REVIEW is this the best way to do this? Is it in the right directory?
# Does this even need to be a class?
class Amount
  attr_accessor :default

  def initialize
    @default = 10_00
  end
end
