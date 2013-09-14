require 'grid'
#Grid has the method that solves the puzzle

describe Grid do
  let(:puzzle) { '015003002000100906270068430490002
  017501040380003905000900081040860070025037204600' # it's an easy sudoku puzzle, row by row }
  }
  let(:grid) {Grid.new puzzle}
  
  it 'fills a board with 81 instances of the cell class' do
    grid.assign_values_to_cells
    expect(grid.board.flatten.all? {|cell| cell.is_a?(Cell)} ).to be_true
  end
  
  it 'checks that the board is an array' do
    grid.assign_values_to_cells
    expect(grid.board).to be_an_instance_of Array
  end


  it 'find the value at each cell' do
    grid.assign_values_to_cells
    expect(grid.cell_value(0,1)).to eq 1
  end

  # it 'should have 9 rows when initialised' do
  #   grid = Grid.new
  #   expect(grid.cells.count).to eq 9
  # end

  # it 'should have 9 elements in each row' do
  #   expect(grid.rows(0).count).to eq 9
  # end

  # it 'returns the contents of a specific row' do
  #   # array = double :array
  #   expect(grid.rows(1).all? { |row| row.is_a?(Cell)}).to be_true
  # end

  # it 'returns the contents of a specific column' do
  #   expect(grid.columns(2).all? {|column| column.is_a?(Cell)}).to be_true
  # end

  # it 'returns 9 cells when row is called' do
  #   expect(grid.rows(2).count).to eq 9
  # end

  # it 'returns 9 cells when column is called' do
  #   expect(grid.columns(3).count).to eq 9
  # end

  

end