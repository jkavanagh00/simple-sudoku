class SudokuGame

    def initialize
        @board = [    
    [0, 0, 2, 1, 7, 0, 0, 0, 6],
    [0, 9, 0, 0, 0, 8, 0, 5, 3],
    [0, 4, 0, 3, 0, 0, 0, 1, 8],
    [0, 0, 0, 8, 0, 0, 6, 4, 0],
    [9, 8, 0, 0, 2, 7, 0, 0, 1],
    [0, 0, 3, 0, 9, 0, 0, 2, 7],
    [5, 0, 1, 9, 0, 0, 0, 7, 0],
    [0, 7, 0, 4, 5, 1, 9, 6, 0],
    [4, 2, 9, 0, 3, 0, 0, 0, 0]
    ]

        @solved_board = [    
    [8, 3, 2, 1, 7, 5, 4, 9, 6],
    [1, 9, 6, 2, 4, 8, 7, 5, 3],
    [7, 4, 5, 3, 6, 9, 2, 1, 8],
    [2, 5, 7, 8, 1, 3, 6, 4, 9],
    [9, 8, 4, 6, 2, 7, 5, 3, 1],
    [6, 1, 3, 5, 9, 4, 8, 2, 7],
    [5, 6, 1, 9, 8, 2, 3, 7, 4],
    [3, 7, 8, 4, 5, 1, 9, 6, 2],
    [4, 2, 9, 7, 3, 6, 1, 8, 5]
    ]

        @mistakes = 0
        @mistake_limit = 0
    end

    def check_win?
        @win = true
        @board.each do |arr|
            if arr.sum != 45 
                @win = false
                break
            end
        end
        return @win  
    end

    def check_lose?
        @mistake_limit > 0 and @mistakes == @mistake_limit  
    end

    def get_mistake_limit
        loop do
            puts "How many mistakes would you like to be able to make?"
            puts "(enter 0 for unlimited mistakes)"
            input = gets.chomp
        
            if input.match?(/^\d+$/)  # check for non-numerical characters
                mistakes = input.to_i
                
                if mistakes == 1
                    @mistake_limit = mistakes
                    puts "You will be able to make 1 mistake before losing."
                    break
                elsif mistakes > 1
                    @mistake_limit = mistakes
                    puts "You will be able to make #{mistakes} mistakes before losing."
                    break
                elsif mistakes == 0
                    @mistake_limit = 0
                    puts "You will be able to make unlimited mistakes."
                    break
                end
            else
                puts "Invalid input. Please enter a positive whole number."
            end
        end
    end

    def display_board
        puts "   A B C   D E F   G H I"
        puts " -------------------------"
        
        @board.each_with_index do |row, row_index|
            if row_index % 3 == 0 && row_index != 0
                puts " -------------------------"
            end

            print "#{row_index + 1}| " 
            row.each_with_index do |cell, col_index|
                if col_index % 3 == 0 && col_index != 0
                    print "| "
                end
                print(cell != 0 ? "#{cell} " : "  ")
            end
            puts "|"  
        end
        puts " -------------------------"
    end

    def correct_move?(arr, num)
        x, y = arr
        @solved_board[y][x] == num
    end

    def initialize_board()
        board = []
        9.times { board.push(Array.new(9, 0)) }
        return board
    end

    def update_board(arr, num)
        x, y = arr
        @board[y][x] = num
    end

    def get_move
        loop do
            puts "Please select a square (A-I, 1-9)"
            coordinates = gets.chomp
            puts "Please enter your guess (1-9)"
            num = gets.chomp.to_i
            converted_coords = convert_coordinates(coordinates)
            if valid_coordinates?(converted_coords) and valid_num?(num) and correct_move?(converted_coords, num)
                update_board(converted_coords, num)
                break
            elsif !(valid_coordinates?(converted_coords)) and !(valid_num?(num))
                puts "Invalid coordinates and guess entered. Please try again, choosing only a character between A & I and a number between 1 & 9 as your coordinates and then another number between 1 & 9 as your guess."
            elsif !(valid_coordinates?(converted_coords))
                puts "Invalid coordinates entered. Please try again, choosing only a character between A & I and a number between 1 & 9."
            elsif !(valid_num?(num))
                puts "Invalid guess entered. Please try again, choosing only a number between 1 & 9."
            elsif !correct_move?(converted_coords, num)
                @mistakes += 1
                puts explain_mistake(converted_coords, num)
                if check_lose?
                    puts "You've made one too many mistakes, you lose!"
                    return :game_over
                end
            end
        end
    end

    def explain_mistake(arr, num)
        result = []
        x, y = arr
        if !correct_row?(y, num) then result.push("row") end
        if !correct_column?(x, num) then result.push("column") end
        if !correct_box?(x, y, num) then result.push("box") end
        
        mistake_info = mistake_limit > 0 ? " Total mistakes: #{mistakes}/#{mistake_limit}." : ""
        
        case result.length
            when 0
                "You made a mistake!#{mistake_info}"
            when 1
                "You made a mistake! There is already a #{num} in this #{result.first}.#{mistake_info}"
            when 2
                "You made a mistake! There is already a #{num} in this #{result.join(' and ')}.#{mistake_info}"
            else
                "You made a mistake! There is already a #{num} in this #{result[0..-2].join(', ')} and #{result.last}.#{mistake_info}"
        end
    end

    def correct_row?(y, num)
        !(@board[y].include?(num))
    end

    def correct_column?(x, num)
        column = []
        9.times { |y| column.push(@board[y][x]) }
        !(column.include?(num))
    end

    def correct_box?(x, y, num)
        box = []
        top_left_x = (x / 3) * 3
        top_left_y = (y / 3) * 3
        for x_index in top_left_x..top_left_x + 2
            for y_index in top_left_y..top_left_y + 2
                box.push(@board[y_index][x_index])
            end
        end
        !(box.include?(num))
    end

    def valid_num?(num)
        num.is_a? Integer and num > 0 and num < 10
    end

    def valid_coordinates?(arr)
        return false if arr.nil? || arr.include?(nil)
        x, y = arr
        x.is_a?(Integer) and x > -1 and x < 9 and y.is_a?(Integer) and y > -1 and y < 9
    end

    def convert_coordinates(str)
        str_arr = str.upcase.gsub(/\s+/, "").split("").sort.reverse

        x_axis = {
            "A" => 0,
            "B" => 1,
            "C" => 2,
            "D" => 3,
            "E" => 4,
            "F" => 5,
            "G" => 6,
            "H" => 7,
            "I" => 8
        }

        y_axis = {
            "1" => 0,
            "2" => 1,
            "3" => 2,
            "4" => 3,
            "5" => 4,
            "6" => 5,
            "7" => 6,
            "8" => 7,
            "9" => 8
        }
        [x_axis[str_arr[0]], y_axis[str_arr[1]]]
    end
end

game = SudokuGame.new
puts "
$$$$$$$\\  $$\\   $$\\ $$$$$$$\\   $$$$$$\\  $$\\   $$\\ $$\\   $$\\ 
$$  __$$\\ $$ |  $$ |$$  __$$\\ $$  __$$\\ $$ | $$  |$$ |  $$ |
$$ |  $$ |$$ |  $$ |$$ |  $$ |$$ /  $$ |$$ |$$  / $$ |  $$ |
$$$$$$$  |$$ |  $$ |$$$$$$$\\ |$$ |  $$ |$$$$$  /  $$ |  $$ |
$$  __$$< $$ |  $$ |$$  __$$\\ $$ |  $$ |$$  $$<   $$ |  $$ |
$$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |  $$ |$$ |\\$$\\  $$ |  $$ |
$$ |  $$ |\\$$$$$$  |$$$$$$$  | $$$$$$  |$$ | \\$$\\ \\$$$$$$  |
\\__|  \\__| \\______/ \\_______/  \\______/ \\__|  \\__| \\______/ 
     Welcome to Ruboku, please employ logic responsibly
"
puts " "
game.get_mistake_limit
loop do
    if game.check_win?
        puts "You win! Congratulations!"
        break
    else
        game.display_board
        result = game.get_move
        if result == :game_over
            break
        end
    end
end