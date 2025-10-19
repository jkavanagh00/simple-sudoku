def initialise_board_array()
    board = []
    9.times { board.push(Array.new(9, "-")) }
    return board
end

board = initialise_board_array()

def check_row(board, y_index, num)
    if board[y_index].include?(num)
        false
    else
        true
    end
end

def check_column(board, x_index, num)
    column = []
    9.times { |y_index| column.push(board[y_index][x_index]) }
    if column.include?(num)
        false
    else
        true
    end
end

def check_box(board, x_index, y_index, num)
    box = []
    top_left_x = (x_index / 3) * 3
    top_left_y = (y_index / 3) * 3
    for x in top_left_x..top_left_x + 2
        for y in top_left_y..top_left_y + 2
            box.push(board[y][x])
        end
    end
    if box.include?(num)
        false
    else
        true
    end
end