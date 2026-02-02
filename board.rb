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

  # Create a hash: {"1"=>:red, "2"=>:green, ...}
  COLOR_MAP = AVAILABLE_COLORS.each_with_index.each_with_object({}) do |(color, index), hash|
    hash[(index + 1).to_s] = color
  end.freeze

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
  # def self.color_menu
  #   COLOR_MAP.map { |num, color| "#{num}: #{color.to_s.colorize(color)}" }.join(" | ")
  # end
  def place_colors(index, input)
    input_array = input.split('')
    row = @grid[index]
    input_array.each_with_index do |digit, i|
      row[:balls][i] = BALLS[COLOR_MAP[digit]]
    end
  end
  def place_pegs(feed)
    
  end
end
# puts Board.color_menu
# b =  Board.new
# b.update(0,'2341')
# puts b
# p "Available colors: #{Board.colors}"
