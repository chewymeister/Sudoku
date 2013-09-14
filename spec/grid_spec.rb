require 'grid'
#Grid has the method that solves the puzzle

describe Grid do
  let(:grid) {Grid.new}
  it 'should have 9 rows when initialised' do
    grid = Grid.new
    expect(grid.cells.count).to eq 9
  end

  it 'should have 9 elements in each row' do
    expect(grid.rows(0).count).to eq 9
  end

  it 'returns the contents of a specific row' do
    # array = double :array
    expect(grid.rows(1).all? { |row| row.is_a?(Cell)}).to be_true
  end

  it 'returns the contents of a specific column' do
    expect(grid.columns(2).all? {|column| column.is_a?(Cell)}).to be_true
  end

  it 'returns 9 cells when row is called' do
    expect(grid.rows(2).count).to eq 9
  end

  it 'returns 0 cells when column is called' do
    expect(grid.columns(3).count).to eq 9
  end

  it 'returns the contents of a box' do
    expect(grid.boxes(2).all? {|box| box.is_a?(Cell)}).to be_true
  end

  it 'returns 9 cells when box is called' do
    expect(grid.boxes(3).count).to eq 9
  end

  it 'assigns box index values to each cell' do
    cell = double
    cell.should_receive(box_index_is).with(1).and_return(1)
    grid.assign_box_index 1
  

    expect(grid.cell).to eq 1
  end

end