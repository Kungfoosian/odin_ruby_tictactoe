# frozen_string_literal: true


require './classes/player'
require './classes/game'

player_x = Player.new('X')
player_o = Player.new('O')
game = Game.new(player_x, player_o)
game.play
