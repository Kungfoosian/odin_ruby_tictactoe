# frozen_string_literal: true

# Player
class Player
  attr_reader :marker, :marked_squares

  def initialize(marker)
    @marker = marker
    @marked_squares = []
  end

  def choose_square
    puts "\n\t***Player #{marker} turn.***"
    print 'Please select a number from board:'
    begin
      choice = Integer(gets.chomp)

      raise RangeError unless choice.between?(0, 8)
    rescue ArgumentError, RangeError
      puts "\tERROR: Please input a number between 0 and 8."
    else
      choice
    end
  end

  def update(square)
    @marked_squares.push(square)
  end
end
