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