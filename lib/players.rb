
require 'colorize'
class PermanentFailureError < StandardError; end
class BadInputError < StandardError; end

class Player
  attr_reader :last_input, :code
end

class HumanPlayer < Player
  def get_input
    @last_input = gets.chomp
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
  attr_accessor :pretended_intelligence
  def initialize
    @pretended_intelligence = {}
  end
  def make_code
    @code = (1..4).reduce(''){|str, _| str + rand(1..6).to_s}
  end 
  def make_guess
    return @last_input = make_code if @pretended_intelligence.empty?
    guess_array = self.use_pretended_intelligence
    @last_input = guess_array.join
  end
  def use_pretended_intelligence
    guess_array = Array.new(4) 
    # RED PASS: Lock in the exact matches first
    @pretended_intelligence.each do |index, info|
      if info[:color] == :red
        guess_array[index] = info[:value]
      end
    end
    # WHITE PASS: Try to move white pegs to NEW empty spots
    @pretended_intelligence.each do |original_index, info|
      next unless info[:color] == :white

      # Find slots that are nil AND are NOT the original index (must move)
      available_slots = guess_array.each_index.select do |i| 
        guess_array[i].nil? && i != original_index 
      end

      # If we found a valid spot, move the white peg there
      if available_slots.any?
        new_spot = available_slots.sample
        guess_array[new_spot] = info[:value]
      end
    end
    #RANDOM PASS: Fill any remaining nils with random numbers
    guess_array.map! do |val|
      val.nil? ? rand(1..6).to_s : val
    end
    guess_array
  end
end
