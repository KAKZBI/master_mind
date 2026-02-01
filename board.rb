require 'colorize'
# require 'pry-byebug'

class Board

  # The "Source of Truth" - 6 fixed colors
  AVAILABLE_COLORS = [:red, :green, :blue, :yellow, :magenta, :white].freeze

  # Automatically build the BALLS hash using the colors above
  BALLS = AVAILABLE_COLORS.each_with_object({ empty: "\u25ef" }) do |color, hash|
    hash[color] = "\u2b24".send(color)
  end.freeze
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

  def self.colors
    AVAILABLE_COLORS #.map { |color| color.to_s.colorize(color) }.join(", ")
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
p "Available colors: #{Board.colors}"
