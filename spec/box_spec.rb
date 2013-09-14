require 'box'

describe Box do

	let(:box) {Box.new}
	let(:cell) {Cell.new 0}
	let(:board) {Array.new(9) {Array.new(9) {cell} } }

	it 'assigns index value 1 to cells beloning to box 1' do
		# cell.should_receive(:assign_box_index).and_return(1)
    box.assign_box_index_1 board

    expect(board[0][0].box_index).to eq 1
    expect(board[2][2].box_index).to eq 1
  end

  # it 'does not assign index values to those that have not been iterated over' do
  #   box.assign_box_index_1 board
  #   expect(board[8][8].box_index).to eq 0
  # end

  it 'troubleshoot. box_1 is an array of appropriate cells' do
    box.assign_box_index_1 board
    # box_1 = board[3..5].map {|row| row[0..2] }

    # expect(box_1).to match_array [1,2,3]
    expect(box.box_1).to eq [1,2,3]
  end

  it 'troubleshoot. board' do
    box.assign_box_index_1 board

    expect(board).to eq [1,2,3]
  end
end