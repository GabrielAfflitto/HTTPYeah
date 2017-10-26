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
    binding.pry
    assert_equal length. ws.dictionary.length
  end

end
