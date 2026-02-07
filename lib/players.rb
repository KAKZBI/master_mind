require 'pry-byebug'
require 'colorize'
class PermanentFailureError < StandardError; end
class BadInputError < StandardError; end

class Player
  attr_reader :last_input, :code
end

class HumanPlayer < Player
  def get_input
    @last_input = gets.chomp#.to_i
  end
  def make_guess
    max_attempts = 3
    begin
      raise PermanentFailureError, "Sorry - Game aborted" if max_attempts == 0
      puts "Select 4 colors by number:"
      # get_input
      input = gets.chomp
      raise BadInputError, "Choose 4 digits representing the colors in order." unless is_valid?(input)
      @last_input = input
    rescue BadInputError => e 
      max_attempts -= 1
      puts "Invalid choice - #{e.message}".red if max_attempts > 0
      puts "Trying " + "#{max_attempts}".red + " more times" if max_attempts > 0
      sleep 0.5
      retry 
    end
  end
  def make_code
    # Reuse the guessing logic to get input
      @code = make_guess
  end
  def is_valid?(input)
    return false unless input.length == 4
    input.split('').all?{|char| char.to_i.between?(1,6)}
  end
end

class ComputerPlayer < Player
  attr_writer :pretended_intelligence
  def initialize
    @pretended_intelligence = []
  end
  def make_code
    @code = (1..4).reduce(''){|str, i| str + rand(1..6).to_s}
  end 
  def make_guess
    @last_input = (1..4).reduce(''){|str, i| str + rand(1..6).to_s}
  end
end
