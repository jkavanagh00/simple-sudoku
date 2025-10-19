def initialise_board_array()
    board = []
    9.times { board.push(Array.new(9, "-")) }
    return board
end

board = initialise_board_array()

def check_row(board, y, num)
    if board[y].include?(num)
        false
    else
        true
    end
end

def check_column(board, x, num)
    column = []
    9.times { |y| column.push(board[y][x]) }
    if column.include?(num)
        false
    else
        true
    end
end

def check_box(board, x, y, num)
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