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
    board.each do |row|
      row.each do |square|
        if square['value'] != ''
          print "[#{square['value']}]"
        else
          print "[#{square['id']}]"
        end
      end
      print "\n"
    end
  end
end

my_board = Board.new
my_board.update_board
