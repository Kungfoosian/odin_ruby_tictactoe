# frozen_string_literal: true

# Creates game board
class GameBoard
  attr_reader :board, :squares_left

  def initialize
    @board = []
    @squares_left = 9

    9.times do |square_index|
      square =
        { id: square_index,
          value: '' }

      @board.push(square)
    end
  end

  def update
    elements_printed = 0
    print "\n\n\t"
    board.each do |square|
      if !square[:value].empty?
        print "[ #{square[:value]} ]"

      else
        print "[ #{square[:id]} ]"

      end

      elements_printed += 1

      print "\n\t" if (elements_printed % 3).zero?
    end
  end

  def register_input(player, square_choice)
    board.each_with_index do |square, index|
      if square[:id] == square_choice && square_empty?(square)
        square[:value] = player.marker
        @squares_left -= 1

        return square_choice

      elsif index == board.length - 1 # End of array, no squares marked
        raise StandardError, "\tERROR: Select another square\n"

      end
    end
  end

  private

  def square_empty?(square)
    if square.value?('X') || square.value?('O')
      false
    else
      true
    end
  end
end