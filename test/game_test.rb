require './test/test_helper'
require './lib/game'
require 'pry'

class GameTest < Minitest::Test
  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end



end
