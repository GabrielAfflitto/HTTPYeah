
class Game
  attr_reader :answer, :path, :guesses
  def initialize
    @answer = rand(100)
    @guesses = []
    @path = path
  end

  def guess(path)
    path.split("=")[1]
  end

  def report
    last_guess = guesses.last
  end

end
