const SudokuGame = require('./simple_sudoku.js');

describe('SudokuGame', () => {
    let game;

    beforeEach(() => {
        // Setup: Create a fresh game instance before each test
        game = new SudokuGame();
    });

    describe('Constructor', () => {
        test('should initialize with correct board dimensions', () => {
            // Test that board has 9 rows
            expect(game.board).toHaveLength(9);
            
            // Test that each row has 9 columns
            game.board.forEach(row => {
                expect(row).toHaveLength(9);
            });
        });
    });

    describe('checkWin', () => {
        test('should return true if passed a winning board', () => {
            // Create a board where each row sums to 45
            const winningBoard = [
                [1, 2, 3, 4, 5, 6, 7, 8, 9], // sum = 45
                [9, 8, 7, 6, 5, 4, 3, 2, 1], // sum = 45
                [5, 5, 5, 5, 5, 5, 5, 5, 5], // sum = 45
                [1, 2, 3, 4, 5, 6, 7, 8, 9], // sum = 45
                [9, 8, 7, 6, 5, 4, 3, 2, 1], // sum = 45
                [1, 2, 3, 4, 5, 6, 7, 8, 9], // sum = 45
                [9, 8, 7, 6, 5, 4, 3, 2, 1], // sum = 45
                [1, 2, 3, 4, 5, 6, 7, 8, 9], // sum = 45
                [9, 8, 7, 6, 5, 4, 3, 2, 1]  // sum = 45
            ];
            
            const result = game.checkWin(winningBoard);
            expect(result).toBe(true);
        });

        test('should return false if passed a non-winning but valid board', () => {
            // Use the current game board (has zeros, rows don't sum to 45)
            const result = game.checkWin(game.board);
            expect(result).toBe(false);
        });
    });

    describe('checkWin', () => {
        test('should return true if passed a winning board', () => {
            // Create a board where each row sums to 45
            const winningBoard = [
                [1, 2, 3, 4, 5, 6, 7, 8, 9], // sum = 45
                [9, 8, 7, 6, 5, 4, 3, 2, 1], // sum = 45
                [5, 5, 5, 5, 5, 5, 5, 5, 5], // sum = 45
                [1, 2, 3, 4, 5, 6, 7, 8, 9], // sum = 45
                [9, 8, 7, 6, 5, 4, 3, 2, 1], // sum = 45
                [1, 2, 3, 4, 5, 6, 7, 8, 9], // sum = 45
                [9, 8, 7, 6, 5, 4, 3, 2, 1], // sum = 45
                [1, 2, 3, 4, 5, 6, 7, 8, 9], // sum = 45
                [9, 8, 7, 6, 5, 4, 3, 2, 1]  // sum = 45
            ];
            
            const result = game.checkWin(winningBoard);
            expect(result).toBe(true);
        });

        test('should return false if passed a non-winning but valid board', () => {
            // Use the current game board (has zeros, rows don't sum to 45)
            const result = game.checkWin(game.board);
            expect(result).toBe(false);
        });
    });
});