class Cell
  attr_reader :value
  attr_reader :box_index
  
  def initialize value
    @value = value
    @candidates = [1,2,3,4,5,6,7,8,9]
    @neighbours = []
    @box_index = nil
  end

  def filled_out?
    @value != 0
  end

  def candidates(neighbours)
    @candidates - neighbours
  end

  def assign_box_index value
    @box_index = value
  end
end