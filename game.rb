require_relative 'players'
require_relative 'board'
require 'pry-byebug'
class Game
  def initialize()
    @codemaker = ComputerPlayer.new
    @codebreaker = HumanPlayer.new
    @board = Board.new
    @colors = @board.class.colors
  end
  def is_valid?(input)
    return false unless input.length == 4
    input.split('').all?{|char| char.to_i.between?(1,6)}
  end
  def show_colors 
    (0...colors.length).reduce('') do |str, i|
      color_symbol = @colors[i]
      background_color_symbol = "on_#{color_symbol.to_s}".to_sym
      str + " #{i+1} ".send(background_color_symbol) + ' '
    end
  end
  def feedback
    guess ='2426'# @codebreaker.last_input
    code ='4251'# @codemaker.code
    feed = []
    code_hash = code.split('').each_with_object(Hash.new(0)){|char, hash| hash[char] += 1}
    # guess_hash = guess.each_with_object(Hash.new(0)){|char, hash| hash[char] += 1}
    for i in 0..guess.length
      if code_hash[guess[i]] > 0
        code_hash[guess[i]] -= 1
        if code[i] == guess[i]
          feed.unshift(:red)
        else
          feed.push(:white)
        end
      end
    end
    feed
  end
end

g = Game.new
p g.feedback