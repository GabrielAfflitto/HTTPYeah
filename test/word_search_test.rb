require './test/test_helper'
require './lib/word_search'
require 'faraday'
require 'pry'

class WordSeachTest < Minitest::Test
  def test_it_exists
    ws = WordSearch.new("/word_search?word=car")

    assert_instance_of WordSearch, ws
  end

  def test_whole_dictionary_is_populated
    ws = WordSearch.new("/word_search?word=car")
    length = File.read('/usr/share/dict/words').length

    assert_equal length, ws.dictionary.length
  end

  def test_for_sample_word
    ws = WordSearch.new("/word_search?word=car")

    assert_equal "car", ws.sample_word
  end

  def test_it_can_find_a_valid_dictionary_word
    ws = WordSearch.new("/word_search?word=car")

    assert_equal "car is a known word", ws.find_word
  end

  def test_it_cannot_find_an_invalid_word
    ws = WordSearch.new("/word_search?word=california")

    assert_equal "california is not a known word", ws.find_word
  end



end
