require_relative "game_class.rb"

welcome_message = "\t\t\tWelcome to the Master Mind game\n".bg_white.bold.underline+
"If you don’t know the rules, check here http://en.wikipedia.org/wiki/Mastermind_(board_game)\n\n"+
"We’ve used the following rules:\n".bold.underline +

"\u25cf" + " The computer is the codemaker;\n"+
"\u25cf" + " The human player is the codebreaker;\n"+
"\u25cf" + " The human player has 12 chances to guess the code;\n"+
+ "\u25cf" + " The codemaker chooses a pattern of four code pegs;\n" + "\u25cf" +
" The code is made up of 4 colors;\n"+
+ "\u25cf" +" Once placed, the codemaker provides feedback by placing from zero to four key pegs\n  in the small holes of the row with the guess. A colored key peg is placed for"+
"\n  each code peg from the guess which is correct in both color and position. A white key peg \n  indicates the existence of a correct color code peg placed in the wrong position.\n\n" +
"\u25cf" + " Available colors:" 
puts "\n"
puts welcome_message
# $ha.keys.each{|key| print $ha[key], " "}

# def playComputer(game)
#     # n=0
#     begin
#         # n += 1
#         # game.clear_screen if n > 1
#         game.clear_screen
#         game.create_board
#         game.display_board
#         computer_pick = '' 
#         4.times do |i|
#             computer_pick += rand(1..6).to_s # random number generation
#         end
#         # puts computer_pick 
#         # puts "You can choose 4 colors by selecting their appropriate number."
#         # game.show_available_color_codes
#         final_message = "Sorry, you lost the game The code was #{game.show_code(computer_pick)}\n Do you want to play again (y/n)? "
#         for i in 0...game.length
            
#             print "\n\n Select your combination of 4 colors: "
#             human_pick = gets.chomp
#             while game.is_bad_pick?(human_pick) do
#                 print "\n Select your combination of 4 colors - each digit must be between 1..6(inclusive) : "
#                 human_pick = gets.chomp
#             end
            
#             game.change_colors(i, human_pick, computer_pick)
#             game.verify(i, human_pick, computer_pick)
#             # binding.pry
#             game.clear_screen
#             game.display_board
            
#             if game.guesser_win?(i)
#                 final_message = "Congratulations! You Break the code in #{i+1} attempts"+ 
#                                 " - it was #{game.show_code(computer_pick)}" +
#                                 "\n Do you want to play again (y/n)? "
#                 break
#             end
        
#         end
#         puts
#         print final_message
#         answer = gets.chomp
#         if answer == 'y' || answer == 'Y'
#             game.clear_screen
#         end
#     end while answer == 'y' || answer == 'Y'
    
# end

one_game = Game.new
print "\n\nDo you want to play (y/n)? "
playComputer(one_game) if gets.chomp == "y" || gets.chomp == 'Y'
