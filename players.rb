require 'pry-byebug'
class Player
end

class HumanPlayer < Player

end

class ComputerPlayer < Player

  def make_code
    @code = (1..4).reduce(''){|str, i| str + rand(1..6).to_s}
  end 
end

p ComputerPlayer.new.make_code