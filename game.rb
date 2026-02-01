require_relative 'players'
require_relative 'board'
class Game
  def initialize()
    codemaker = ComputerPlayer.new
    codebreaker = HumanPlayer.new
    board = Board.new
  end
  def is_valid?(guess)
    return false unless guess.length == 4
    guess.split('').all?{|char| char.to_i.between?(1,6)}
  end
end