class SudokuGame

    def initialize
        @board = initialize_board
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

    def valid_move?(x, y, num)
        valid_row?(y, num) and valid_column?(x, num) and valid_box?(x, y, num)
    end

    def initialize_board()
        board = []
        9.times { board.push(Array.new(9, 0)) }
        return board
    end

    def get_move
        puts "Please select a column (A-I)"
        x_coordinate = gets.chomp
        puts "Please select a row (1-9)"
        y_coordinate = gets.chomp
        puts "Please enter your guess"
        num = gets.chomp.to_i
        return x_coordinate, y_coordinate, num
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
        x, y = arr
        x.is_a?(Integer) and x > -1 and x < 9 and y.is_a?(Integer) and y > -1 and y < 9
    end

    def convert_coordinates(str)
        str_arr = str.upcase.gsub(/\s+/, "").split("")

        x_axis = {
            "A" => 0,
            "B" => 1,
            "C" => 2,
            "D" => 3,
            "E" => 4,
            "F" => 5,
            "G" => 6,
            "H" => 7,
            "I" => 8,
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