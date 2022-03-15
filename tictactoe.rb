# frozen_string_literal: true

require './classes/game_board'
require './classes/player'
require './classes/game'

player_x = Player.new('X')
player_o = Player.new('O')
game_board = GameBoard.new
game = Game.new(player_x, player_o, game_board)
game.play
