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
    @frozen_indexes = []
    @frozen_values = Array.new(4)
  end
  def make_code
    @code = (1..4).reduce(''){|str, i| str + rand(1..6).to_s}
  end 
  def make_guess
    return @last_input = (1..4).reduce(''){|str, i| str + rand(1..6).to_s} unless @pretended_intelligence.length > 0
    guess_array = self.use_pretended_intelligence
    @last_input = guess_array.reduce('') do |str, char_color|
      if guess_array[i]
        str + char_color
      else 
        str + rand(1..6).to_s
      end
    end
  end
  def use_pretended_intelligence
    guess_array = Array.new(4) 
    # @frozen_indexes.each_with_index{|pos, i| guess_array[i] = pos}
    @pretended_intelligence.each_with_index do |hash, i|
      next if @frozen_indexes.include?(hash[:position])
      if hash[:color] == :red
        @frozen_indexes << hash[:position]
        @frozen_values[hash[:position]] = hash[:value]
      elsif hash[:color] == :white
        available_positions = @frozen_values.filter_map.with_index{|char_color, i| i unless char_color}
        # Do not consider actual position
        available_positions.delete(hash[:position])
        # choose a new available position
        new_position = available_positions.sample
        guess_array[new_position] = hash[:value]
      end
    end
    @frozen_values.each_with_index{|char_color, i| guess_array[i] = char_color}
    guess_array
  end
end
