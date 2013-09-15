require 'cell'
require 'grid'

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