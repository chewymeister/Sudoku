#'209703810410205607875196023306520100100004359047309068000400980924867001050000002'
#'010200604000004023000000100007490008080352940050017036506020001179083000803600759'
#'035020040200700036000400590086970000000180000000056807762000001013000000504200000'
#'430060090001020746607050080005007000010840000000003002070905800928100300000200000'
#'650008003700010890310590047030281006200000004501607000820060570104709302970020400'

# require 'cell'
# require 'grid'

#HARD PUZZLE:"800000000003600000070090200050007000000045700000100030001000068008500010090000400"
#ULTIMATE HARD PUZZLE:"00000000000000000000000000000000000000000000000000000000000000000000000000000000"
# require 'cell'
# require 'grid'

class Box

  def row_range(index)
    case index
    when 1,2,3
      0..2
    when 4,5,6
      3..5
    when 7,8,9
      6..8
    end
  end

  def column_range(index)
    case index
    when 1,4,7
      0..2
    when 2,5,8
      3..5
    when 3,6,9
      6..8
    end
  end

  def assign_box_index_new(board, index)
    board[row_range(index)].map do |row|
      row[column_range(index)]
    end.flatten.each do |cell|
      cell.assign_box_index index
    end
  end

  def assign_box_indices board
    for index in 1..9
      assign_box_index_new(board,index)
    end
  end

end

class Cell

  attr_accessor :value
  attr_reader :box_index
  attr_reader :neighbours
  attr_reader :row_index
  attr_reader :column_index
  attr_reader :candidates

  def initialize value
    @value = value
    @candidates = [1,2,3,4,5,6,7,8,9]
    @neighbours = []
    @solvable = true
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
    # @neighbours.clear
  end

  def filled_out?
    @value != 0
  end

  def solvable?
    @solvable == true
  end

  def unsolvable!
    @solvable = false
  end

  def attempt_to_solve(neighbours)
    # attempt = @candidates - neighbours
    # if attempt == @candidates
    #   @neighbours.clear
    #   unsolvable!
    # else
      @candidates -= neighbours
      if @candidates.count == 1
        @value = @candidates.pop
        @neighbours.clear
      else
        @neighbours.clear
        @candidates
      end
    # end
  end

  def assume candidate
    @value = candidate
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
    @box.assign_box_indices @board
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
        # puts "error"
    end
  end

  def set_board
    assign_values_to_cells
    assign_box_index_values
    assign_row_column_index_values
  end

  def assign_neighbours_to cell
      neighbours = []
      neighbours << fetch_row(cell.row_index).flatten.map {|cell|cell.value}
      neighbours << fetch_column(cell.column_index).flatten.map {|cell|cell.value}
      neighbours << fetch_box(cell.box_index).flatten.map{|cell|cell.value}
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
    @board.flatten.select do |cell|
      !cell.filled_out?
    end.count == 0
  end

  # def board_unsolvable?
  #   @board.flatten.select do |cell|
  #     !cell.solvable?
  #   end.count >= 1
  # end

SIZE = 81

  def solve_board
    # if !board_unsolvable?
    #   until solved?
    #     solve
    #   end
    # elsif board_unsolvable?
    #   try_harder!
    # end
    outstanding_before, looping = SIZE, false
    while !solved? && !looping
      solve
      outstanding = @board.flatten.count {|c| c.filled_out?}
      looping = outstanding_before == outstanding
      outstanding_before = outstanding
    end
      try_harder unless solved?
  end

  def try_harder
    blank_cell = @board.flatten.select do |cell|
      !cell.filled_out?
    end.first

    blank_cell.candidates.each do |candidate|
      blank_cell.assume candidate
      board = replicate(@board)
      board.set_board
      board.solve_board

      if board.solved?
        steal_solution(board)
        return @board
      end
    end
  end

  def steal_solution board
    @board = board
  end

  def replicate board
    board = Grid.new create_board_string(board)
    board.set_board
    board
  end

  def create_board_string board
     board_string = board.flatten.map do |cell|
      cell.value
    end.join
    board_string
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

