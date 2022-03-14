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

  def update
    board.each do |row|
      row.each do |square|
        if !square['value'].empty?
          print "[#{square['value']}]"
        else
          print "[#{square['id']}]"
        end
      end
      print "\n"
    end
  end

  def register_input(player, square_choice)
    unless square_empty?(square_choice)

    end
  end

  private

  def square_empty?(square_choice)
    board.each do |row|
      row.each do |square|
        unless square[:id] == square_choice && (square.value?('X') || square.value?('O'))
          true
        else
          false
      end
    end
  end
end

# Player
class Player
  def initialize(marker)
    @marker = marker
  end

  private

  def choose_square
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
end

# Game
class Game
  attr_accessor :current_player

  def initialize(player1, player2, board)
    @player1 = player1
    @player2 = player2
    @board = board
    @someone_won = false
    @current_player = @player1
  end

  def play
    until @someone_won
      @board.update

      player_choice = current_player.choose_square

      # @board.is_square_empty?(player_choice)
      @board.register_input(current_player, player_choice)

      @someone_won = @board.check_for_winner

      current_player = @player1 ? @player2 : @player1
    end
  end
end
