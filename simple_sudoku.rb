def initialise_board_array()
    board = []
    9.times { board.push(Array.new(9, "-"))}
    return board
end

board = initialise_board_array()

def check_row(arr, num)
    if arr.include?(num)
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