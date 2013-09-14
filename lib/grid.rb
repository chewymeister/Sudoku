require 'cell'

class Grid

  attr_reader :cells
  def initialize
    @cells = Array.new(9){Array.new(9){Cell.new}}
  end

  def rows(row_index)
    @cells[row_index]
  end

  def columns(column_index)
    @cells.map do |row|
      row[column_index]
    end
  end

  def boxes(box_index)
    Array.new(9){Cell.new}
  end

  def assign_box_index value
    @cells[0..2].map do |row|
      row[0..2].map do |element|
        element.box_index_is value
      end
    end.flatten
  end



  def solve

  end


end
