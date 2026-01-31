require 'colorize'
# require 'pry-byebug'

class Board
  # Use Constants for fixed data
  BALLS = {
    empty: "\u25ef",
    white: "\u2b24",
    green: "\u2b24".green,
    purple: "\u2b24".magenta,
    red: "\u2b24".red,
    yellow: "\u2b24".yellow,
    blue: "\u2b24".blue
  }.freeze

  PEGS = {
    empty: "\u25cb",
    white: "\u25cf",
    red: "\e[31m\u25CF\e[0m"
  }.freeze

  # UI Constants
  TOP_LEFT = "\u250c"
  HORIZONTAL = "\u2500"
  TOP_RIGHT = "\u2510"
  VERTICAL = "\u2502"
  LOW_LEFT = "\u2514"
  LOW_RIGHT = "\u2518"

  def initialize(rounds = 12)
    @grid = create_grid(rounds)
    # binding.pry
  end

  def create_grid(rounds)
    # Using symbols like :empty to match the BALLS hash
    Array.new(rounds) do
      {
        balls: Array.new(4, BALLS[:empty]),
        pegs: Array.new(4, PEGS[:empty])
      }
    end
  end

  def to_s
    header = TOP_LEFT + (HORIZONTAL * 16) + TOP_RIGHT
    footer = LOW_LEFT + (HORIZONTAL * 16) + LOW_RIGHT
    
    # Map each row into a formatted string
    rows = @grid.map do |row|
      balls = row[:balls].join(" ")
      pegs = row[:pegs].join("")
      "#{VERTICAL} #{balls} #{VERTICAL} #{pegs} #{VERTICAL}"
    end
    # binding.pry
    [header, rows, footer].flatten.join("\n")
  end
end

puts Board.new