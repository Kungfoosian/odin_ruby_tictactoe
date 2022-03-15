# frozen_string_literal: true

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