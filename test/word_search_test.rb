require './test/test_helper'
require './lib/word_search'
require 'faraday'
require 'pry'

class WordSeachTest < Minitest::Test
  def test_it_exists
    ws = WordSearch.new

    assert_instance_of WordSearch, ws
  end

  def test_whole_dictionary_is_populated
    ws = WordSearch.new
    length = File.read('/usr/share/dict/words').length

    assert_equal length, ws.dictionary.length
  end

  # def test_for_sample_word
  #   ws = WordSearch.new
  #
  #   assert_equal "car", ws.sample_word("/word_search?word=car")
  # end

  def test_it_can_find_a_valid_dictionary_word
    ws = WordSearch.new

    assert_equal "CAR is a known word", ws.find_word("/word_search?word=car")
  end

  def test_it_cannot_find_an_invalid_word
    ws = WordSearch.new

    assert_equal "CALIFORNIA is not a known word", ws.find_word("/word_search?word=california")
  end

end
