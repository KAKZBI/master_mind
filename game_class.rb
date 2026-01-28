require_relative 'monkey_patch.rb'
require_relative "variables.rb"

class Game
    # attr_accessor :board
    def initialize
        @board = []
    end
    def create_board(numb_of_turns = 6)
        @board.clear
        1..numb_of_turns.times {|i| @board.push($a_ball.clone)}#deep clone the $a_ball hash(pass by value)
    end
    def display_board
        numb_of_turns = @board.length 
        space = ' '
        for i in 0...numb_of_turns
         puts "#{TOP_LEFT}#{HORIZONTAL*26}#{TOP_RIGHT}" + "#{TOP_LEFT}#{HORIZONTAL*13}#{TOP_RIGHT}\n" +
          "#{VERTICAL}#{space*2}#{@board[i]['ball1']}#{space*5}#{@board[i]['ball2']}#{space*5}#{@board[i]['ball3']}#{space*5} #{@board[i]['ball4']}#{space*4}#{VERTICAL}" +
          "#{VERTICAL} #{@board[i]['v_ball1']}#{space*2}#{@board[i]['v_ball2']}#{space*2}#{@board[i]['v_ball3']}#{space*2}#{@board[i]['v_ball4']}#{space*2}#{VERTICAL}\n" +
          "#{LOW_LEFT}#{HORIZONTAL*26}#{LOW_RIGHT}" + "#{LOW_LEFT}#{HORIZONTAL*13}#{LOW_RIGHT}\n"
        end
        puts "Available colours: "
        $ha.keys.each{|key| print $ha[key], " "}
    end
    def guesser_win?(index)
        v_ball_red = "\e[31m\u25CF\e[0m"
        end_game = true 
            for i in 0..3
                prop = 'v_ball' + (i+1).to_s
                return false if @board[index][prop] != v_ball_red
            end
        return end_game
    end
    def length
        return @board.length
    end
    def change_colors(index, codeguesser_pick, codemaker_pick)
        
        for i in 0...codeguesser_pick.length
            prop = 'ball' + (i + 1).to_s
            @board[index][prop] = $ball[$numb_color[codeguesser_pick[i]]]
            # puts "board[#{index}][#{prop}] = #{$ball[$numb_color[codeguesser_pick[i]]]}"
        end
        sleep(0.5)
        self.verify(index, codeguesser_pick, codemaker_pick)
        
    end
    def show_available_color_codes
        $ha.keys.each{|key| print $ha[key], " "}
    end
    # private
    def verify(index, codeguesser_pick, codemaker_pick)
        codemaker_array = []
        #Build an array containing each character of the codemaker
        codemaker_pick.each_char {|char| codemaker_array << char}
        codeguesser_array = []
        #Build an array containing each character of the codeguessr
        codeguesser_pick.each_char {|char| codeguesser_array << char}
        # codemaker_array.each_with_object({}) do |code, codemaker_hash|
        #     codemaker_hash[code] = true
        # end
        codemaker_hash = {}
        #Build a hash for the codemaker 
        codemaker_array.each_with_index{|char, index| codemaker_hash[index] = char}
        codeguesser_hash = {}
        #Build a hash for the codeguesser 
        codeguesser_array.each_with_index{|char, index| codeguesser_hash[index] = char}
        verification_hash = {}
        #get the reds in the verification hash first
        for i in 0...codeguesser_array.length
            verification_hash[i] = 'red' if codeguesser_hash[i] == codemaker_hash[i]
        end
        # verification_array = verification_hash.values
        #get the whites in the verification hash
        for i in 0...codeguesser_array.length
            if codemaker_hash.values.include?(codeguesser_hash[i]) 
                verification_hash[i] = 'white' if !verification_hash[i]
            end
        end
        # p  verification_hash
        verification_array = verification_hash.values
        
        #Give the clues
        for i in 0...verification_array.length
            prop = 'v_ball' + (i+1).to_s
            @board[index][prop] = $coin[verification_array[i]]
            # p "@board[#{index}][#{prop}] = #{$coin[verification_array[i]]}"
        end
        
    end
    def is_bad_pick?(pick)
        return true if pick.length != 4
        pick_array = []
        answer = false
        pick.each_char{|c| pick_array.push(c.to_i)}
        for i in 0...pick_array.size
            if pick_array[i] < 1 || pick_array[i] > 6 
                answer = true
                return answer
            end
        end
        return answer
    end
    def show_code(code)
        the_code = ''
        # code.each_char{|key| print $ha[key], " "}
        code.each_char{|key| the_code += $ha[key] + " "}
        return the_code
    end
    def clear_screen
        system('clear') || system('cls')
    end
end

