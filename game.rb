require_relative 'players'
require_relative 'board'
require 'pry-byebug'
class Game
  attr_reader :board
  def initialize()
    @codemaker = ComputerPlayer.new
    @codebreaker = HumanPlayer.new
    @board = Board.new
    @colors = @board.class.colors
    @last_feedback = []
  end
  # def is_valid?(input)
  #   return false unless input.length == 4
  #   input.split('').all?{|char| char.to_i.between?(1,6)}
  # end
  # Return a string containing all colors represented by a digit between 1 and 6 inclusive
  def start
    puts @board
    puts "COLOR MENU"
    puts @board.color_menu
    @codemaker.make_code
  end
  def run 
    round = 1
    @verdict = "You lost"
    until self.guesser_win? || round > @board.size
      guess = self.take_guess
      @board.place_colors(round - 1, guess)
      @board.place_pegs(round - 1, self.feedback)
      self.clear_screen
      puts @board
      round += 1
      @verdict = "You win" if guesser_win?
    end
  end
  def result
    "#{@verdict} - code is #{@codemaker.code}"
  end
  def colors_map 
    (0...@colors.length).reduce('') do |str, i|
      color_symbol = @colors[i]
      background_color_symbol = "on_#{color_symbol.to_s}".to_sym
      str + " #{i+1} ".send(background_color_symbol) + ' '
    end
  end
  # Return an array containing symbols representing feedback
  def feedback
    guess = @codebreaker.last_input
    code = @codemaker.code
    @last_feedback = []
    code_hash = code.split('').each_with_object(Hash.new(0)){|char, hash| hash[char] += 1}
    for i in 0..guess.length
      if code_hash[guess[i]] > 0
        code_hash[guess[i]] -= 1
        if code[i] == guess[i]
          @last_feedback.unshift(:red)
        else
          @last_feedback.push(:white)
        end
      end
    end
    @last_feedback
  end
  # Determine if the Code guesser has won
  def guesser_win?
    @last_feedback == [:red, :red, :red, :red]
  end
  def take_guess
    # binding.pry
    puts "Available colors: #{colors_map}"  if @codebreaker.class == HumanPlayer
    begin
      @codebreaker.make_guess
    rescue PermanentFailureError => e 
        puts e.message
        return # exit(1)
    end
  end
end

# g = Game.new
# puts g.take_guess