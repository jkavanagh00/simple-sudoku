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
        9.times { @board.push(Array.new(9, 0)) }
        return board
    end

    def valid_row?(y, num)
        if @board[y].include?(num)
            false
        else
            true
        end
    end

    def valid_column?(x, num)
        column = []
        9.times { |y| column.push(@board[y][x]) }
        if column.include?(num)
            false
        else
            true
        end
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
        if box.include?(num)
            false
        else
            true
        end
    end

    def valid_num?(num)
        num.is_a? Integer and num > 0 and num < 10
    end

    def valid_coordinates?(x, y)
        (x.is_a?(String) and x.match?(/^[A-I]$/)) and (y.is_a?(Integer) and y > 0 and y < 10)
    end

    def convert_coordinates(x, y)
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
            1 => 0,
            2 => 1,
            3 => 2,
            4 => 3,
            5 => 4,
            6 => 5,
            7 => 6,
            8 => 7,
            9 => 8
        }
        [x_axis[x], y_axis[y]]
    end
end