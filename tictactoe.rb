# frozen_string_literal: true

# Creates game board
class Board
  attr_reader :board

  def initialize
    # @board = [[{}, {}, {}], [{}, {}, {}], [{}, {}, {}]]

    # square_id = 0

    # @board.each do |row|
    #   row.each do |square|
    #     square[:id] = square_id
    #     square[:value] = ''
    #     square_id += 1
    #   end
    # end
    @board = []

    9.times do |square_index|
      square =
        { id: square_index,
          value: '' }

      @board.push(square)
    end
  end

  def update
    # board.each do |row|
    #   row.each do |square|
    #     if !square['value'].empty?
    #       print "[#{square['value']}]"
    #     else
    #       print "[#{square['id']}]"
    #     end
    #   end
    #   print "\n"
    # end
    board.each do |square|
      3.times do
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
    # board.each do |row|
    #   row.each do |square|
    #     raise StandardError, "\tERROR: Select another square" unless
    #       square[:id] == square_choice && square_empty?(square)

    #     square[:value] = player.marker
    #   end
    # end
    board.each do |square|
      raise StandardError, "\tERROR: Select another square" unless
        square[:id] == square_choice && square_empty?(square)

      square[:value] = player.marker
    end
  end

  def check_for_winner
    win_patterns = [[0, 1, 2], [0, 4, 8], [0, 3, 6], [3, 4, 5], [6, 7, 8], [1, 4, 7], [2, 5, 8], [2, 4, 6]]

    win_patterns.any? do |pattern|
      pattern.all? do |square|
        board
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
  attr_reader :marker

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

      begin
        player_choice = current_player.choose_square
        @board.register_input(current_player, player_choice)
      rescue StandardError => e
        puts e
      else
        @someone_won = @board.check_for_winner
        current_player = @player1 ? @player2 : @player1
      end
    end
  end
end
