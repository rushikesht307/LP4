#include <iostream>
#include <vector>
using namespace std;

void printBoard(vector<vector<int>> &board)
{
    int n = board.size();
    for (int i = 0; i < n; i++){
        for (int j = 0; j < n; j++){
            if (board[i][j] == 1)
                cout << "Q \t";
            else
                cout << ". \t";
        }
        cout << endl;
    }
}

// Function to check if it's safe to place a queen at board[row][col]
bool isSafe(vector<vector<int>> &board, int row, int col)
{
    int n = board.size();

    // Check the column
    for (int i = 0; i < row; i++)
        if (board[i][col] == 1)
            return false;

    // Check upper-left diagonal
    for (int i = row, j = col; i >= 0 && j >= 0; i--, j--)
        if (board[i][j] == 1)
            return false;

    // Check upper-right diagonal
    for (int i = row, j = col; i >= 0 && j < n; i--, j++)
        if (board[i][j] == 1)
            return false;

    return true;
}

bool solveNQueens(vector<vector<int>> &board, int row)
{
    int n = board.size();

    // Base case: If all queens are placed
    if (row >= n)
        return true;

    // Try placing a queen in all columns of the current row
    for (int col = 0; col < n; col++){
        if (isSafe(board, row, col)){
            // Place the queen
            board[row][col] = 1;

            // Recursively place the rest of the queens
            if (solveNQueens(board, row + 1))
                return true;

            // Backtrack if placing queen here doesn't lead to a solution
            board[row][col] = 0;
        }
    }

    // If no place is found for the queen in this row, return false
    return false;
}

int main()
{

    int n, row, col;
    cout << "Enter the value of N (size of the board): ";
    cin >> n;

    vector<vector<int>> board(n, vector<int>(n, 0));

    cout << "Enter the position to place the first queen (row and column): ";
    cin >> row >> col;
    board[row][col] = 1;

    // Use backtracking to place the rest of the queens
    if (solveNQueens(board, row + 1)){
        cout << "\nSolution for " << n << "-Queens problem:\n";
        printBoard(board);
    }
    else{
        cout << "\nNo solution exists for the given starting position.\n";
    }

    return 0;
}

/*
    The time complexity of the N-Queens problem is O(n^n) in the worst case. Here's a concise explanation:

    For each of the n rows, we try placing a queen in any of the n columns.

    This generates n possibilities for the first row, n possibilities for the second row, and so on, leading to a total of 
    𝑛 × n x . . × 𝑛 = 𝑛^𝑛 recursive calls.

    Each placement requires checking if it's safe, which takes O(n) time to check the column and diagonals.

    Thus, the overall time complexity is O(n ^ n )


*/