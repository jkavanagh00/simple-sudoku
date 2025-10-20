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
    end

    def valid_win?
        @win = true
        @board.each do |arr|
            if arr.sum != 45 
                @win = false
                break
            end
        end
        return @win  
    end

    def display_board
        puts "-------------------------"
        
        @board.each_with_index do |row, row_index|
            if row_index % 3 == 0 && row_index != 0
                puts "-------------------------"
            end

            print "| " 
            row.each_with_index do |cell, col_index|
                if col_index % 3 == 0 && col_index != 0
                    print "| "
                end
                print(cell != 0 ? "#{cell} " : "  ")
            end
            puts "|"  
        end
        puts "-------------------------"
    end

    def valid_move?(arr, num)
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

            if valid_coordinates?(converted_coords) and valid_num?(num) and valid_move?(converted_coords, num)
                update_board(converted_coords, num)
                break
            elsif !(valid_coordinates?(converted_coords)) and !(valid_num?(num))
                puts "Invalid coordinates and guess entered. Please try again, choosing only a character between A & I and a number between 1 & 9 as your coordinates and then another number between 1 & 9 as your guess."
            elsif !(valid_coordinates?(converted_coords))
                puts "Invalid coordinates entered. Please try again, choosing only a character between A & I and a number between 1 & 9."
            elsif !(valid_num?(num))
                puts "Invalid guess entered. Please try again, choosing only a number between 1 & 9."
            elsif !valid_move?(converted_coords, num)
                puts "You made a mistake!"
            end
        end
    end

    def valid_row?(y, num)
        !(@board[y].include?(num))
    end

    def valid_column?(x, num)
        column = []
        9.times { |y| column.push(@board[y][x]) }
        !(column.include?(num))
    end

    def valid_box?(x, y, num)
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