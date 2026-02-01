require_relative 'players'
require_relative 'board'
require 'pry-byebug'
class Game
  def initialize()
    @codemaker = ComputerPlayer.new
    @codebreaker = HumanPlayer.new
    @board = Board.new
  end
  def is_valid?(guess)
    return false unless guess.length == 4
    guess.split('').all?{|char| char.to_i.between?(1,6)}
  end
  def show_colors 
    colors = @board.class.colors
    (0...colors.length).reduce('') do |str, i|
      color_symbol = colors[i]
      background_color_symbol = "on_#{color_symbol.to_s}".to_sym
      str + " #{i+1} ".send(background_color_symbol) + ' '
    end
  end
end

g = Game.new
puts "Available colors: #{g.show_colors}"