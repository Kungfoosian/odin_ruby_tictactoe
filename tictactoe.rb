# frozen_string_literal: true

# Creates game board
class Board
  attr_reader :board

  def initialize
    @board = [[{}, {}, {}], [{}, {}, {}], [{}, {}, {}]]

    square_id = 0

    @board.each do |row|
      row.each do |square|
        square['id'] = square_id
        square['value'] = ''
        square_id += 1
      end
    end
  end

  def update_board
  end
end

my_board = Board.new
p my_board.board
