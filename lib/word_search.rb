
class WordSearch
  attr_reader :dictionary, :path
  def initialize(path)
    @dictionary = File.read('/usr/share/dict/words')
    @path = path
  end

  def sample_word
    path.split("=")[1]
  end

  def find_word
    # word = path.split("=")[1]
    if dictionary.include?(sample_word)
      "#{sample_word} is a known word"
    else
      "#{sample_word} is not a known word"
    end
  end

end
