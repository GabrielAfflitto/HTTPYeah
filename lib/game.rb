
class Game
  attr_reader :guess, :guess_counter, :answer
  def initialize
    @answer = rand(100)
    @guess_counter = 0
    @guess = []
    binding.pry
  end

  

  def guess_tracker(guess)
    guess_counter += 1
    guess << guess.to_i
  end

  def last_guess
    guess[-1].to_i
  end

  def next_guess
    "<p><font face = 'Helvetica'><strong>Total guesses:
    #{guess_counter}</font face></strong></p>
    <p><font face = 'Helvetica'><strong>Your last guess was
    #{last_guess} and #{high_low}</font face></strong>"
  end

end
