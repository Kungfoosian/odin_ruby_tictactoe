# frozen_string_literal: true

# Creates game board
class Board
  attr_reader :board

  def initialize
    @board = []

    9.times do |square_index|
      square =
        { id: square_index,
          value: '' }

      @board.push(square)
    end
  end

  def update
    elements_printed = 0

    board.each do |square|
      if !square[:value].empty?
        print "[#{square[:value]}]"

      else
        print "[#{square[:id]}]"

      end

      elements_printed += 1

      print "\n" if (elements_printed % 3).zero?
    end
  end

  def register_input(player, square_choice)
    board.each_with_index do |square, index|
      if square[:id] == square_choice && square_empty?(square)
        square[:value] = player.marker

        return square_choice

      elsif index == board.length - 1
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

  def update_choice(square)
    @marked_squares.push(square)
  end
end

# Game
class Game
  attr_accessor :current_player

  WIN_PATTERNS = [[0, 1, 2], [0, 4, 8], [0, 3, 6], [3, 4, 5], [6, 7, 8], [1, 4, 7], [2, 5, 8], [2, 4, 6]].freeze

  def initialize(player1, player2, board)
    @player1 = player1
    @player2 = player2
    @board = board
    @winner = nil
    @current_player = @player1
  end

  def play
    while @winner.nil?
      @board.update

      begin
        player_choice = current_player.choose_square
        marked_square = @board.register_input(current_player, player_choice)
      rescue StandardError => e
        puts e
      else
        @current_player.update_choice(marked_square)
        @winner = Game.check_for_winner(current_player)
        @current_player = @current_player == @player1 ? @player2 : @player1
      end
    end

    puts "#{@winner.marker} won!"
  end

  def self.check_for_winner(player)
    win_condition_met = WIN_PATTERNS.any? do |pattern|
      (pattern & player.marked_squares).sort == pattern.sort
    end

    return player if win_condition_met

    nil
  end
end

player_x = Player.new('X')
player_o = Player.new('O')
game_board = Board.new
game = Game.new(player_x, player_o, game_board)
game.play
