
class Game
  attr_reader :guesses
  attr_accessor :answer
  def initialize
    @answer = rand(1..100)
    @guesses = []
  end

  # def guess(path)
  #   path.split("=")[1]
  # end



  def guess_tracker(guess)
    guesses << guess
    if guess == answer
      "Correct"
    elsif guess < answer
      "Your guess was too low."
    elsif guess > answer
      "Your guess was too high."
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
    if last_guess == answer
      "You are correct!"
    elsif last_guess < answer
      "Your guess was too low."
    else
      "Your guess was too high"
    end
  end

end
