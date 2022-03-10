# frozen_string_literal: true

# Creates game board
class Board
  attr_accessor board

  def initialize
    @board = []

    (0...9).each { |index| @board[index] = { square_id: index, value: '' } }
  end
end
