require 'cell'
require 'box'

class Grid

  attr_reader :board
  def initialize puzzle
    @puzzle = puzzle.chars
    @board = nil
    @box = Box.new
  end

  def assign_values_to_cells
    @board = @puzzle.map do |value|
      Cell.new value.to_i
    end.each_slice(9).to_a
  end

  def assign_box_index_values board
    @box.assign_box_index_1 board
    @box.assign_box_index_2 board
    @box.assign_box_index_3 board
    @box.assign_box_index_4 board
    @box.assign_box_index_5 board
    @box.assign_box_index_6 board
    @box.assign_box_index_7 board
    @box.assign_box_index_8 board
    @box.assign_box_index_9 board
  end    

  def cell_value row,column
    @board[row][column].value
  end

  def cells_box_index_value row,column
    @board[row][column].box_index
  end

  def fetch_row(row_index)
    @board[row_index]
  end

  def fetch_column(column_index)
    @board.map do |row|
      row[column_index]
    end
  end

  def fetch_box(box_index)
    case
      when box_index == 1
        @board[0..2].map{|row| row[0..2]}
      when box_index == 2
        @board[0..2].map{|row| row[3..5]}
      when box_index == 3
        @board[0..2].map{|row| row[6..9]}
      when box_index == 4
        @board[3..5].map{|row| row[0..2]}
      when box_index == 5
        @board[3..5].map{|row| row[3..5]}
      when box_index == 6
        @board[3..5].map{|row| row[6..9]}
      when box_index == 7
        @board[6..9].map{|row| row[0..2]}
      when box_index == 8
        @board[6..9].map{|row| row[3..5]}
      when box_index == 9
        @board[6..9].map{|row| row[6..9]}
      else
        puts "error"
    end
  end

  def solve

  end

end
