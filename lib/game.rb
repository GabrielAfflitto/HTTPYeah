
class Game
  attr_reader :guesses
  attr_accessor :answer
  def initialize
    @answer = rand(100)
    @guesses = []
  end

  def guess(path)
    path.split("=")[1]
  end

  def guess_tracker(path)
    guess = path.split("=")[1]
    if guess.to_i == answer
      "Correct"
    elsif guess.to_i < answer
      "Too low"
    else
      "Too high"
    end
  end

  def report
    last_guess = guesses.last
    if guesses.empty?
      "No guesses have been made."
    else
      "Your last guess was #{last_guess}, #{guess_checker(last_guess)}"
    end
  end

  def guess_checker(last_guess)
    if last_guess.to_i == answer
      "You are correct!"
    elsif last_guess.to_i < answer
      "Your guess was too low."
    else
      "Your guess was too high"
    end
  end

end
