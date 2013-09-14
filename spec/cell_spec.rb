require 'cell'

describe Cell do
	let(:cell) {Cell.new 0}

  it 'checks to see if it is cell is empty' do
    expect(cell.filled_out?).to be_false
  end

  it 'has a list of candidates' do
    expect(cell.candidates([])).to be_an_instance_of Array
  end

  it 'takes list of neighbours as an argument and takes it away from itself' do
    neighbours = [1,2,6,7,8,9]
    expect(cell.candidates(neighbours)).to match_array([3,4,5])
  end

  it 'assigns box index value given to it by box' do
    # box = double :box
    cell.assign_box_index 1

    expect(cell.box_index).to eq 1
  end
end