class SudokuGame {
    constructor() {
        this.mistakes = 0;
        this.mistakeLimit = 0;
        this.win = false;
        this.lose = false;
        this.board = [
            [0, 0, 2, 1, 7, 0, 0, 0, 6],
            [0, 9, 0, 0, 0, 8, 0, 5, 3],
            [0, 4, 0, 3, 0, 0, 0, 1, 8],
            [0, 0, 0, 8, 0, 0, 6, 4, 0],
            [9, 8, 0, 0, 2, 7, 0, 0, 1],
            [0, 0, 3, 0, 9, 0, 0, 2, 7],
            [5, 0, 1, 9, 0, 0, 0, 7, 0],
            [0, 7, 0, 4, 5, 1, 9, 6, 0],
            [4, 2, 9, 0, 3, 0, 0, 0, 0]
        ];
        this.solvedBoard = [
            [8, 3, 2, 1, 7, 5, 4, 9, 6],
            [1, 9, 6, 2, 4, 8, 7, 5, 3],
            [7, 4, 5, 3, 6, 9, 2, 1, 8],
            [2, 5, 7, 8, 1, 3, 6, 4, 9],
            [9, 8, 4, 6, 2, 7, 5, 3, 1],
            [6, 1, 3, 5, 9, 4, 8, 2, 7],
            [5, 6, 1, 9, 8, 2, 3, 7, 4],
            [3, 7, 8, 4, 5, 1, 9, 6, 2],
            [4, 2, 9, 7, 3, 6, 1, 8, 5]
        ];
    }

    checkWin(board) {
        for (let i = 0; i < board.length; i++) {
            if (board[i].reduce((x, y) => x + y) !== 45 || new Set(board[i]).length !== 9) return false;
        }
        return true;
    }

    checkLose() { 
        return this.mistakes > 0 && this.mistakes >= this.mistakeLimit;
    }

    checkMove(y, x, number) {
        return this.checkRow(y, number) && this.checkColumn(x, number) && this.checkBox(y, x, number);
    }

    createEmptyBoard() {
        let emptyBoard = [];
        for (let i = 0; i < 9; i++) {
            emptyBoard.push([]);
            for (let j = 0; j < 9; j++) {
                emptyBoard[i].push(0);
            }
        }
        return emptyBoard;
    }

    updateBoard(y, x, number) {
        this.board[y][x] = number;
        return true;
    }

    checkRow(y, number) {
        return !this.board[y].includes(number)
    }

    checkColumn(x, number) {
        for (let i = 0; i < 9; i++) {
            if (this.board[i][x] === number) return false
        }
        return true
    }

    checkBox(y, x, number) {
        const topLeftX = Math.floor(x / 3) * 3;
        const topLeftY = Math.floor(y / 3) * 3;
        for (let i = topLeftY; i < topLeftY + 3; i++) {
            for (let j = topLeftX; j < topLeftX + 3; j++) {
                if (this.board[i][j] === number) return false
            }
        }
        return true
    }

    makeMove(y, x, number) {
        if (this.checkMove(y, x, number)) {
            this.updateBoard(y, x, number);
            if (this.checkWin(this.board)) {
                this.win = true;
            }
        } else {
            this.mistakes++;
            if (this.checkLose()) {
                this.lose = false;
            }
        }
        return true;
    }
}


const game = new SudokuGame;
console.log(game.board)