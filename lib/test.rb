#'209703810410205607875196023306520100100004359047309068000400980924867001050000002'
#'010200604000004023000000100007490008080352940050017036506020001179083000803600759'
#'035020040200700036000400590086970000000180000000056807762000001013000000504200000'
#'430060090001020746607050080005007000010840000000003002070905800928100300000200000'
#'650008003700010890310590047030281006200000004501607000820060570104709302970020400'

#HARD PUZZLE:"800000000003600000070090200050007000000045700000100030001000068008500010090000400"
#ULTIMATE HARD PUZZLE:"00000000000000000000000000000000000000000000000000000000000000000000000000000000"


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
  
  def assign_box_index value
    @box_index = value
  end

  def assign(neighbours)
    @neighbours += neighbours
    @neighbours.flatten!
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
      @candidates -= neighbours
      if @candidates.count == 1
        @value = @candidates.pop
        @neighbours.clear
      else
        @neighbours.clear
      end
  end

  def assume candidate
    @value = candidate
  end

end

class Grid
  
  SIZE = 81

  attr_reader :board
  def initialize puzzle
    @puzzle = puzzle.chars
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

  def fetch_row(row_index)
    @board[row_index].flatten
  end

  def fetch_column(column_index)
    @board.map do |row|
      row[column_index]
    end.flatten
  end

  def get_cell_values_from board
    board.flatten.map(&:value)
  end

  def fetch_box(box_index)
    @board.flatten.select do |cell|
      cell.box_index == box_index
    end.flatten
  end

  def set_board
    assign_values_to_cells
    assign_box_index_values
    assign_row_column_index_values
  end

  def assign_neighbours_to cell
      neighbours = []
      neighbours <<fetch_row(cell.row_index).map {|cell| cell.value}
      neighbours <<fetch_column(cell.column_index).map {|cell| cell.value}
      neighbours <<fetch_box(cell.box_index).map {|cell| cell.value}
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

  def solve_board
    outstanding_before, looping = SIZE, false
    while !solved? && !looping
      solve
      outstanding = @board.flatten.count {|c| c.filled_out?}
      looping = outstanding_before == outstanding
      outstanding_before = outstanding
    end
      try_harder unless solved?
  end

  def create_blank_cell
    blank_cell = @board.flatten.select do |cell|
      !cell.filled_out?
    end.first
  end

  def try_harder
    blank_cell = create_blank_cell

    blank_cell.candidates.each do |candidate|
      blank_cell.assume candidate
      board_copy = replicate(@board)

      board_copy.solve_board

      if board_copy.solved?
        steal_solution(board_copy)
        break
      end
    end
  end

  def steal_solution board
    @board = board.board
  end

  def replicate board
    board_replicate = Grid.new create_current_puzzle_string_of(board)
    board_replicate.set_board
    board_replicate
  end

  def create_current_puzzle_string_of board
    current_puzzle_string = board.flatten.map do |cell|
      cell.value
    end.join
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