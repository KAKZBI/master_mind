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
    self.display_instructions 
    clear_screen
    puts "\n************ COLOR MENU *************"
    puts @board.class.color_menu
    puts
    puts @board
    puts
    @codemaker.make_code
  end
  def greetings
    splash_screen
    simulate_loading("Initializing Neural Network")
    simulate_loading("Loading Security Protocols")
    
    puts "\nWelcome, Agent. Your objective is simple:".bold
    puts "1. If you are the #{'MAKER'.red}, you must craft a code that is impossible to break."
    puts "2. If you are the #{'BREAKER'.green}, you must decrypt the 4-digit sequence."
    puts "\nAvailable roles:"
    puts "[#{'M'.red}] - Code Maker (Human vs CPU)"
    puts "[#{'B'.green}] - Code Breaker (CPU vs Human)"
    puts "-------------------------------------------------------------\n"
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
    @guess_history = [] # To store the paper trail
    round = 1
    @verdict = "Code Breaker Lost"
    until self.guesser_win? || round > @board.size
      guess = self.take_guess
      @guess_history << guess # Save the guess
      @board.place_colors(round - 1, guess)
      @board.place_pegs(round - 1, self.feedback)
      sleep(1)
      self.clear_screen
      puts @board
      puts "Current Guess: #{guess}" if @codebreaker.is_a?(ComputerPlayer)
      sleep(2) if @codebreaker.is_a?(ComputerPlayer)
      if guesser_win?
        @verdict = "Code Breaker Wins"
        @total_rounds = round # Save the winning round number
      break
      end
      round += 1
      @total_rounds = [round, @board.size].min
    end
  end
  
  def feedback
      #Clear old intelligence so the bot doesn't act on stale data
      @codebreaker.pretended_intelligence.clear if @codebreaker.is_a?(ComputerPlayer)
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
          @codebreaker.pretended_intelligence[i] = {color: :red, value: char} if @codebreaker.is_a?(ComputerPlayer)
          # binding.pry
        end
      end

      # Second Pass: White Pegs
      guess_chars.each_with_index do |char, i|
        next if matched_indices.include?(i)

        if code_counts[char].to_i > 0
          @last_feedback << :white
          code_counts[char] -= 1
          @codebreaker.pretended_intelligence[i] = {color: :white, value: char} if @codebreaker.is_a?(ComputerPlayer)
        end
      end

      @last_feedback
  end

  def guesser_win?
    @last_feedback.count(:red) == 4 # == [:red, :red, :red, :red]
  end
  def take_guess
    puts "Available colors: #{colors_map}"  if @codebreaker.is_a?(HumanPlayer)
    @codebreaker.make_guess
  end
  def colors_map 
    (0...@colors.length).reduce('') do |str, i|
      color_symbol = @colors[i]
      background_color_symbol = "on_#{color_symbol.to_s}".to_sym
      str + " #{i+1} ".send(background_color_symbol) + ' '
    end
  end
  def result
    clear_screen
    puts @board
    puts "\n"

    # 1. Big Visual Header
    if guesser_win?
      puts "╔════════════════════════════════════╗".green
      puts "║          ACCESS GRANTED            ║".green
      puts "╚════════════════════════════════════╝".green
    else
      puts "╔════════════════════════════════════╗".red
      puts "║          SYSTEM LOCKED             ║".red
      puts "╚════════════════════════════════════╝".red
    end

    # 2. Reveal the Secret Code with colors
    revealed_code = @codemaker.code.chars.map do |char| 
      char.colorize(Board::COLOR_MAP[char])
    end.join(" ")
    
    puts "\nSECRET CODE: #{revealed_code}"
    puts "TOTAL ATTEMPTS: #{@total_rounds}\n"

    # 3. The Paper Trail (Visual History)
    puts "\n" + "--- DECRYPTION LOG ---".bold.cyan
    @guess_history.each_with_index do |guess, i|
      # Format round number (01, 02)
      round_num = format('%02d', i + 1)
      
      # Use Colored Digits
      colored_guess = guess.chars.map do |char| 
        char.colorize(Board::COLOR_MAP[char])
      end.join(" ")
      
      puts "Round #{round_num}: #{colored_guess}"
    end
    puts "----------------------"
  end
  # Return an array containing symbols representing feedback
  
  # Determine if the Code guesser has won
  
  def clear_screen
    system('clear') || system('cls')
  end

  def splash_screen
    clear_screen
    title = <<~ART
      #{'  __  __           _                      _           _  '.magenta}
      #{' |  \\/  |         | |                    (_)         | | '.magenta}
      #{' | \\  / | __ _ ___| |_ ___ _ __ _ __ ___  _ _ __   __| | '.magenta}
      #{' | |\\/| |/ _` / __| __/ _ \\ \'__| \'_ ` _ \\| | \'_ \\ / _` | '.white}
      #{' | |  | | (_| \\__ \\ ||  __/ |  | | | | | | | | | | (_| | '.white}
      #{' |_|  |_|\\__,_|___/\\__\\___|_|  |_| |_| |_|_|_| |_|\\__,_| '.white}
                                                          
    ART
    puts title
    puts "-------------------------------------------------------------".blue
    puts "       STRICTLY CONFIDENTIAL - AUTHORIZED ACCESS ONLY        ".bold
    puts "-------------------------------------------------------------".blue
    puts "\n"
  end
  def simulate_loading(message)
    print message
    3.times do
      sleep(0.5)
      print ".".cyan
    end
    puts "\n"
  end
  def display_instructions
    # Using the constants from your Board class for consistency
    border = Board::HORIZONTAL * 50
    
    puts "\n#{Board::TOP_LEFT}#{border}#{Board::TOP_RIGHT}"
    puts "#{Board::VERTICAL} #{'MISSION BRIEFING:'.bold.underline.cyan}#{' ' * 33}#{Board::VERTICAL}"
    puts "#{Board::VERTICAL}#{' ' * 50}#{Board::VERTICAL}"
    
    # Explain the Pegs using the actual icons from your Board
    puts "#{Board::VERTICAL} #{Board::PEGS[:red]} #{'RED PEG:'.red}   Correct Color & Correct Position   #{Board::VERTICAL}"
    puts "#{Board::VERTICAL} #{Board::PEGS[:white]} #{'WHITE PEG:'.white} Correct Color but Wrong Position  #{Board::VERTICAL}"
    puts "#{Board::VERTICAL} #{Board::PEGS[:empty]} #{'EMPTY:'.gray}     No match found for this slot      #{Board::VERTICAL}"
    
    puts "#{Board::VERTICAL}#{' ' * 50}#{Board::VERTICAL}"
    puts "#{Board::VERTICAL} #{'GOAL:'.yellow} Crack the 4-digit code in #{Board.new.size} rounds. #{Board::VERTICAL}"
    puts "#{Board::LOW_LEFT}#{border}#{Board::LOW_RIGHT}\n"
    
    print "Press #{'ENTER'.bold.green} to begin the mission..."
    gets
  end
end
