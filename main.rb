require_relative "game.rb"

# welcome_message = "\t\t\tWelcome to the Master Mind game\n".bg_white.bold.underline+
# "If you don’t know the rules, check here http://en.wikipedia.org/wiki/Mastermind_(board_game)\n\n"+
# "We’ve used the following rules:\n".bold.underline +

# "\u25cf" + " The computer is the codemaker;\n"+
# "\u25cf" + " The human player is the codebreaker;\n"+
# "\u25cf" + " The human player has 12 chances to guess the code;\n"+
# + "\u25cf" + " The codemaker chooses a pattern of four code pegs;\n" + "\u25cf" +
# " The code is made up of 4 colors;\n"+
# + "\u25cf" +" Once placed, the codemaker provides feedback by placing from zero to four key pegs\n  in the small holes of the row with the guess. A colored key peg is placed for"+
# "\n  each code peg from the guess which is correct in both color and position. A white key peg \n  indicates the existence of a correct color code peg placed in the wrong position.\n\n" +
# "\u25cf" + " Available colors:" 
# puts "\n"

master_mind = Game.new
puts "Welcome to the Master Mind game"
master_mind.start
master_mind.run
puts master_mind.result
