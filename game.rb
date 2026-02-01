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
    
  end
end

g = Game.new
puts "Available colors: #{g.show_colors}"