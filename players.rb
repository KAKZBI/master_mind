require 'pry-byebug'
class Player
  attr_reader :last_input, :code
end

class HumanPlayer < Player
  # attr_reader :last_input
  def get_input
    @last_input = gets.chomp#.to_i
  end
end

class ComputerPlayer < Player
  def make_code
    @code = (1..4).reduce(''){|str, i| str + rand(1..6).to_s}
  end 
end

# pp = HumanPlayer.new
# current_guess = pp.get_input
# puts "The variable current_guess is: #{current_guess}"
# puts "The stored @last_input is: #{pp.last_input}"