require_relative 'players'
require_relative 'board'
require 'pry-byebug'

class BadRoleChoiceError < StandardError; end
class Game
  attr_reader :board
  def initialize()
    self.greetings
    self.set_roles(self.ask_role)
    # binding.pry
    @board = Board.new
    @colors = @board.class.colors
    @last_feedback = []
  end

  def start
    puts "\n************ COLOR MENU *************"
    puts @board.class.color_menu
    puts
    puts @board
    puts
    @codemaker.make_code
  end
  def greetings
    puts "You can either be the code Maker or the code Breaker."
    puts "Possible choices: \n"\
         "Code Maker: m or M\n"\
         "Code Breaker: b or B"
    puts "Any other choice is invalid\n"
  end

  def ask_role
    max_attempts = 3
    begin
    raise PermanentFailureError, "Sorry - Game aborted" unless max_attempts > 0
    print "Choose your role - [M]aker or [B]reaker: "
    choice = gets.chomp.downcase
    raise BadRoleChoiceError, "Invalid choice: #{choice}" unless choice.match?(/\A[mb]\z/i)
    choice
    rescue BadRoleChoiceError => e
      max_attempts -= 1
      puts e.message.colorize(:red) if max_attempts > 0
      puts "Trying #{max_attempts} more times" if max_attempts > 0
      retry 
    end
  end

  def set_roles(choice)
    if choice == 'm'
      @codemaker = HumanPlayer.new
      @codebreaker = ComputerPlayer.new
    elsif choice == 'b'
      @codemaker = ComputerPlayer.new
      @codebreaker = HumanPlayer.new
    end
  end
  def run 
    round = 1
    @verdict = "You lost"
    until self.guesser_win? || round > @board.size
      guess = self.take_guess
      @board.place_colors(round - 1, guess)
      @board.place_pegs(round - 1, self.feedback)
      sleep(1)
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
      guess_chars = @codebreaker.last_input.chars
      code_chars = @codemaker.code.chars
      @last_feedback = []
      
      #hash for char occurences
      code_counts = code_chars.tally 
      matched_indices = []

      # First Pass: Red Pegs
      guess_chars.each_with_index do |char, i|
        if char == code_chars[i]
          @last_feedback << :red
          code_counts[char] -= 1
          matched_indices << i
        end
      end

      # Second Pass: White Pegs
      guess_chars.each_with_index do |char, i|
        next if matched_indices.include?(i)

        if code_counts[char].to_i > 0
          @last_feedback << :white
          code_counts[char] -= 1
        end
      end

      @last_feedback
  end
  # Determine if the Code guesser has won
  def guesser_win?
    @last_feedback == [:red, :red, :red, :red]
  end
  def take_guess
    puts "Available colors: #{colors_map}"  if @codebreaker.class == HumanPlayer
    @codebreaker.make_guess
  end
  def clear_screen
    system('clear') || system('cls')
  end
end
# g = Game.new
# p g.feedback
# g.greetings
# g.ask_role