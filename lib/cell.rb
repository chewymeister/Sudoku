class Cell
  attr_reader :value
  def initialize value
    @value = value
    @candidates = [1,2,3,4,5,6,7,8,9]
    @neighbours = []
  end

  def filled_out?
    @value != 0
  end

  def candidates(neighbours)
    @candidates - neighbours
  end
  
end