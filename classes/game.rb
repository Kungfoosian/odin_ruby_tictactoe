# frozen_string_literal: true

require './classes/game_board'

# Game
class Game
  WIN_PATTERNS = [[0, 1, 2], [0, 4, 8], [0, 3, 6], [3, 4, 5], [6, 7, 8], [1, 4, 7], [2, 5, 8], [2, 4, 6]].freeze

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @board = GameBoard.new
    @winner = nil
    @current_player = [@player1, @player2].sample
  end

  def play
    @board.print_board

    while @winner.nil? && !@board.squares_left.zero?
      begin
        player_choice = @current_player.choose_square

        marked_square = @board.register_input(@current_player, player_choice)

      rescue StandardError => e
        puts e
      else
        update(marked_square)

      end
    end

    @winner = 'No one' if @board.squares_left.zero?

    puts "\n\n\t**** #{@winner} won! ****\n\n"
  end

  
  private
  
  def update(marked_square)
    @current_player.update(marked_square)
    
    @board.print_board
    
    @winner = check_for_winner(@current_player)
    
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
  
  def check_for_winner(player)
    win_condition_met = WIN_PATTERNS.any? do |pattern|
      (pattern & player.marked_squares).sort == pattern.sort
    end

    return player.marker if win_condition_met 

    nil
  end
end