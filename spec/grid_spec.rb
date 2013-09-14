require 'grid'
#Grid has the method that solves the puzzle

describe Grid do
  let(:puzzle) {'015003002000100906270068430490002017501040380003905000900081040860070025037204600'}
  let(:grid) {Grid.new puzzle}
  let(:board) {grid.board}
  before {grid.assign_values_to_cells}
  before {grid.assign_box_index_values board}

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
    # grid.assign_box_index_values board
    expect(grid.cells_box_index_value(0,2)).to eq 1
  end

  it 'returns the cells box index value' do
    # grid.assign_box_index_values board
    expect(grid.cells_box_index_value(3,8)).to eq 6
  end
  
  it 'returns an array of cells located in the appropriate box' do
    box_2 = grid.fetch_box 2
    expect(box_2).to be_an_instance_of Array
  end

  it 'verifies there are only 9 elements after fetching a box' do
    box_3 = grid.fetch_box 3
    expect(box_3.flatten.count).to eq 9
  end

  xit 'verfies the box index after retrieving the box' do
    box_4 = grid.fetch_box 4
    expect(box_4.flatten.each {|cell| cell.box_index}).to eq 9
  end

  



end

  # before {grid.assign_box_index_values board}
