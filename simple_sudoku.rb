def initialise_board_array()
    board = []
    9.times { board.push(Array.new(9, "-")) }
    return board
end

board = initialise_board_array()

def check_row?(board, y, num)
    if board[y].include?(num)
        false
    else
        true
    end
end

def check_column?(board, x, num)
    column = []
    9.times { |y| column.push(board[y][x]) }
    if column.include?(num)
        false
    else
        true
    end
end

def check_box?(board, x, y, num)
    box = []
    top_left_x = (x / 3) * 3
    top_left_y = (y / 3) * 3
    for x_index in top_left_x..top_left_x + 2
        for y_index in top_left_y..top_left_y + 2
            box.push(board[y_index][x_index])
        end
    end
    if box.include?(num)
        false
    else
        true
    end
end

def check_move?(board, x, y, num)
    check_row(board, y, num) and check_column(board, x, num) and check_box(board, x, y, num)
end

def validate_move_input?(num)
    num.is_a? Integer and num > 0 and num < 10
end

def convert_coordinate_input(x, y)
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