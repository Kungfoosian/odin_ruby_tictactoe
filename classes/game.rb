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
    @current_player = [@player1, @player2].sample
  end

  def play
    while @winner.nil? && !@board.squares_left.zero?
      begin
        player_choice = current_player.choose_square

        marked_square = @board.register_input(current_player, player_choice)

      rescue StandardError => e
        puts e
      end

      @current_player.update_choice(marked_square)

      @board.update

      @winner = Game.check_for_winner(current_player)

      @current_player = @current_player == @player1 ? @player2 : @player1
    end

    @winner = 'No one' if @board.squares_left.zero?

    puts "\n\n\t**** #{@winner} won! ****\n\n"
  end

  def self.check_for_winner(player)
    win_condition_met = WIN_PATTERNS.any? do |pattern|
      (pattern & player.marked_squares).sort == pattern.sort
    end

    return player.marker if win_condition_met 

    nil
  end
end