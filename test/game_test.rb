require './test/test_helper'
require './lib/game'
require 'pry'

class GameTest < Minitest::Test
  def test_it_exists
    game = Game.new

    assert_instance_of Game, game
  end

  def test_that_guess_tracker_evaluates_the_guesses
    game = Game.new
    game.answer = 55
    assert_equal "Too low", game.guess_tracker("/game?guess=13")
  end

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

  def test_that_report_returns_the_correct_information_about_the_guess
    game = Game.new
    # binding.pry
    game.answer = 43
    game.guesses << game.guess("/game?guess=13")
    assert_equal "Your last guess was 13, Your guess was too low.", game.report

    game.guesses << game.guess("/game?guess=90")
    assert_equal "Your last guess was 90, Your guess was too high", game.report

    game.guesses << game.guess("/game?guess=43")
    assert_equal "Your last guess was 43, You are correct!", game.report
  end

  def test_guess_checker_will_return_correct_information_about_guess
    game = Game.new
    game.answer = 67

    assert_equal "Your guess was too low.", game.guess_checker("55")
  end

end
