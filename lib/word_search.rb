
class WordSearch
  attr_reader :dictionary
  def initialize
    @dictionary = File.read('/usr/share/dict/words')
  end

  def find_word(path)
    sample_word = path.split("=")[1]
    if dictionary.include?(sample_word)
      "#{sample_word.upcase} is a known word"
    else
      "#{sample_word.upcase} is not a known word"
    end
  end

end
