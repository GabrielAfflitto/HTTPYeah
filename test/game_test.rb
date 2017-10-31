require './test/test_helper'
require './lib/game'
require 'pry'

class GameTest < Minitest::Test
  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  # def test_that_it_can_take_a_guess
  #   game = Game.new
  #
  #   assert_equal "13", game.guess("/game?guess=13")
  # end

  def test_that_guess_tracker_can_store_all_guesses
    game = Game.new
    game.guesses << game.guess("/game?guess=13")
    assert_equal ["13"], game.guesses
    game.guesses << game.guess("/game?guess=11")
    assert_equal ["13", "11"], game.guesses
  end

  def test_that_we_can_find_the_amount_of_guesses
    game = Game.new

    game.guesses << game.guess("/game?guess=13")
    assert_equal 1, game.guesses.count
    game.guesses << game.guess("/game?guess=11")
    assert_equal 2, game.guesses.count
  end

  def test_that_report_gives_us_the_correct_information_about_the_guess
    game = Game.new
    
    game.guess_tracker("/game?guess=13")
    game.guess_tracker("/game?guess=11")

    assert_equal "", game.report
    assert_equal "", game.report
  end



end
