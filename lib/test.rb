class Cell
  attr_reader :value
  attr_reader :box_index
  attr_reader :neighbours
  attr_reader :row_index
  attr_reader :column_index
  def initialize value
    @value = value
    @candidates = [1,2,3,4,5,6,7,8,9]
    @neighbours = []
    @box_index = nil
    @row_index = nil
    @column_index = nil
  end

  def assign_row index
    @row_index = index
  end

  def assign_column index
    @column_index = index
  end

  def assign neighbours
    @neighbours + neighbours
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

# require 'cell'
# require 'box'

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

  def assign_box_index_values 
    @box.assign_box_index_1 @board
    @box.assign_box_index_2 @board
    @box.assign_box_index_3 @board
    @box.assign_box_index_4 @board
    @box.assign_box_index_5 @board
    @box.assign_box_index_6 @board
    @box.assign_box_index_7 @board
    @box.assign_box_index_8 @board
    @box.assign_box_index_9 @board
  end    

  def assign_row_column_index_values
    row_index = nil
    column_index = nil
    @board.each do |row|
      row_index = @board.index(row)
      row.each do |cell|
        column_index = row.index(cell)
        cell.assign_row(row_index)
        cell.assign_column(column_index)
      end
    end                 
  end

  def find_row_index row,column
    @board[row][column].row_index
  end

  def find_column_index row,column
    @board[row][column].column_index
  end

  def cell_value row,column
    @board[row][column].value
  end

  def find_box_index row,column
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

  def set_board
    assign_values_to_cells
    assign_box_index_values
    assign_row_column_index_values
  end

  def assign_neighbours_to_all_cells
    neighbours = []
    row_index = nil
    column_index = nil
    box_index = nil
    @board.flatten.each do |cell|
      row_index = cell.row_index
      column_index = cell.column_index
      box_index = cell.box_index
      neighbours << fetch_row(row_index){|cell|cell.value}.to_a
      neighbours << fetch_column(column_index){|cell|cell.value}.to_a
      neighbours << fetch_box(box_index){|cell|cell.value}.to_a
      cell.assign neighbours
      neighbours.clear
    end    
  end



  def solve

  end
end

# require 'cell'
# require 'grid'

class Box
  
  def assign_box_index_1 board
    box_1 = board[0..2].map do |row|
      row[0..2]
    end

    box_1.flatten.each do |cell|
      cell.assign_box_index 1
    end
  end

  def assign_box_index_2 board
    box_2 = board[0..2].map do |row|
      row[3..5]
    end

    box_2.flatten.each do |cell|
      cell.assign_box_index 2
    end
  end

  def assign_box_index_3 board
    box_3 = board[0..2].map do |row|
      row[6..9]
    end

    box_3.flatten.each do |cell|
      cell.assign_box_index 3
    end
  end

  def assign_box_index_4 board
    box_4 = board[3..5].map do |row|
      row[0..2]
    end

    box_4.flatten.each do |cell|
      cell.assign_box_index 4
    end
  end

  def assign_box_index_5 board
    box_5 = board[3..5].map do |row|
      row[3..5]
    end

    box_5.flatten.each do |cell|
      cell.assign_box_index 5
    end
  end

  def assign_box_index_6 board
    box_6 = board[3..5].map do |row|
      row[6..9]
    end

    box_6.flatten.each do |cell|
      cell.assign_box_index 6
    end
  end

  def assign_box_index_7 board
    box_7 = board[6..9].map do |row|
      row[0..2]
    end

    box_7.flatten.each do |cell|
      cell.assign_box_index 7
    end
  end

  def assign_box_index_8 board
    box_8 = board[6..9].map do |row|
      row[3..5]
    end

    box_8.flatten.each do |cell|
      cell.assign_box_index 8
    end
  end


  def assign_box_index_9 board
    box_9 = board[6..9].map do |row|
      row[6..9]
    end

    box_9.flatten.each do |cell|
      cell.assign_box_index 9
    end
  end

end