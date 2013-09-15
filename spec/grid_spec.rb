require 'grid'
#Grid has the method that solves the puzzle

describe Grid do
  let(:puzzle) {'015003002000100906270068430490002017501040380003905000900081040860070025037204600'}
  let(:grid) {Grid.new puzzle}
  let(:board) {grid.board}
  before {grid.set_board}

  it 'fills a board with 81 instances of the cell class' do
    expect(grid.board.flatten.all? {|cell| cell.is_a?(Cell)} ).to be_true
  end
  
  it 'checks that the board is an array' do
    expect(grid.board).to be_an_instance_of Array
  end

  it 'find the value at each cell' do
    expect(grid.cell_value(0,1)).to eq 1
  end

  it 'should have 9 elements in each row' do
    expect(grid.fetch_row(0).count).to eq 9
  end
  
  it 'returns 9 cells when row is called' do
    expect(grid.fetch_row(2).count).to eq 9
  end

  it 'returns the contents of a specific row' do
    expect(grid.fetch_row(1).all? { |row| row.is_a?(Cell)}).to be_true
  end

  it 'returns 9 cells when column is called' do
    expect(grid.fetch_column(3).count).to eq 9
  end

  it 'returns the contents of a specific column' do
    expect(grid.fetch_column(2).all? {|column| column.is_a?(Cell)}).to be_true
  end

  it 'returns the contents of a specific box' do
    expect(grid.find_box_index(0,2)).to eq 1
  end

  it 'returns the cells box index value' do
    expect(grid.find_box_index(3,8)).to eq 6
  end
  
  it 'returns an array of cells located in the appropriate box' do
    box_2 = grid.fetch_box 2
    expect(box_2).to be_an_instance_of Array
  end

  it 'verifies there are only 9 elements after fetching a box' do
    box_3 = grid.fetch_box 3
    expect(box_3.flatten.count).to eq 9
  end

  it 'verfies the box index after retrieving the box' do
    box_4 = grid.fetch_box 4
    expect(box_4.flatten.each {|cell| cell.box_index == 4}).to be_true
  end

  it 'assigns row indexes to each cell' do

    expect(grid.find_row_index(4,6)).to eq 4
    expect(grid.find_row_index(6,2)).to eq 6
  end

  it 'assigns column indexes to each cell' do

    expect(grid.find_column_index(3,2)).to eq 2
  end

  it 'sets the board ready for adding neighbours and solving' do

    expect(grid.find_column_index(4,6)).to eq 6
    expect(grid.find_row_index(7,2)).to eq 7
    expect(grid.find_box_index(3,4)).to eq 5
  end

  xit 'assigns neighbours to each cell' do
    grid.assign_neighbours_to
    expect(grid.board.flatten.each {|cell| cell.neighbours}).not_to be_nil
  end

  it 'assigns neighbours to the cell' do
    grid.assign_neighbours_to board[0][0]
    grid.assign_neighbours_to board[7][2]

    expect(board[0][0].neighbours).to match_array [0,1,5,0,0,3,0,0,2,0,0,2,4,5,0,9,8,0,0,1,5,0,0,0,2,7,0]
    expect(board[7][2].neighbours).to match_array [8,6,0,0,7,0,0,2,5,5,0,0,0,1,3,0,0,7,9,0,0,8,6,0,0,3,7]
  end

  it 'iterates once through and attempts to solve the board' do
    grid.solve
    # grid.solve

    expect(grid.cell_value(8,0)).to eq 1
    # expect(grid.cell_value(1,4)).to eq 2
    expect(grid.cell_value(4,8)).to eq 9
  end


  it 'checks to see if the entire grid has been solved' do
    grid.solve
    expect(grid.solved?).to be_false 
  end

  it 'it solves the entire grid' do
    grid.solve_board
    expect(grid.solved?).to be_true
  end

  it 'displays the whole grid' do
    grid.inspect_board
  end

  it 'displays a solved board' do
    grid.solve_board
    grid.inspect_board
  end

end







