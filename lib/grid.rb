require 'cell'

class Grid

  attr_reader :board
  def initialize puzzle
    @puzzle = puzzle.chars
    @board = nil
  end

  def assign_values_to_cells
    @board = @puzzle.map do |value|
      Cell.new value.to_i
    end.each_slice(9).to_a
  end

  def cell_value row,column
    @board[row][column].value
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
