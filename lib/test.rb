#'209703810410205607875196023306520100100004359047309068000400980924867001050000002'
#'010200604000004023000000100007490008080352940050017036506020001179083000803600759'
#'035020040200700036000400590086970000000180000000056807762000001013000000504200000'
#'430060090001020746607050080005007000010840000000003002070905800928100300000200000'
#'650008003700010890310590047030281006200000004501607000820060570104709302970020400'
class Cell
  attr_reader :value
  attr_reader :box_index
  attr_reader :neighbours
  attr_reader :row_index
  attr_reader :column_index
  attr_reader :candidates
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

  def assign(neighbours)
    @neighbours += neighbours
    @neighbours.flatten!
  end

  def filled_out?
    @value != 0
  end

  def attempt_to_solve(neighbours)
    @candidates -= neighbours
    if @candidates.count == 1
      @value = @candidates.pop
    else
      @candidates
    end
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

  def find_neighbours row,column
    @board[row][column].neighbours
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

  def assign_neighbours_to cell
      neighbours = []
      row_index = cell.row_index
      column_index = cell.column_index
      box_index = cell.box_index
      neighbours << fetch_row(row_index).flatten.map {|cell|cell.value}
      neighbours << fetch_column(column_index).flatten.map {|cell|cell.value}
      neighbours << fetch_box(box_index).flatten.map{|cell|cell.value}
      cell.assign neighbours
  end

  def solve
    @board.flatten.each do |cell|
      if cell.filled_out?
        cell
      else 
        assign_neighbours_to cell
        cell.attempt_to_solve cell.neighbours
      end
    end
  end

  def solved?
    unsolved_cells = []
    unsolved_cells << @board.flatten.select do |cell|
      !cell.filled_out?
    end
    unsolved_cells.flatten.count == 0
  end

  def solve_board
    until solved?
      solve
    end
  end

  def inspect_board
    puts "-------------------------------------"
    @board.each do |row|
      row.each do |cell|
        print "| #{cell.value} "
      end
    puts "|\n-------------------------------------"
    end
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