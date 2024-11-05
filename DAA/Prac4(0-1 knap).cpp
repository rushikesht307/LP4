#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int ZeroOne_Knapsack(int W, int n, vector<pair<int, int>> &items)
{

    // State Definiton of dp[i][j] ==> 
    // dp[i][j] represents the maximum profit achievable using the first 'i' items
    // with a knapsack capacity of 'j'.
    vector<vector<int>> dp(n + 1, vector<int>(W + 1, 0));


    for (int i = 1; i <= n; i++)
    {
        // profit and weight of the current item
        int profit = items[i - 1].first;
        int weight = items[i - 1].second;

        for (int j = 1; j <= W; j++) 
        {
            // Check if the current item's weight is less than or equal to the capacity (Valid Case)
            if (weight <= j)
            {
                // Calculate the maximum profit including or excluding the current item

                // Include the item: add its profit to the best profit of the remaining capacity 
                // best profit of the remaining capacity ==> i.e. maximum profit that can be achieved by using
                //  the first i - 1 items (i.e., all items before the current one)
                //  with a reduced capacity of (j - weight).
                int include = profit + dp[i - 1][j - weight];

                // Skip the item: carry forward the best profit without including the current item
                int skip = dp[i - 1][j];

                // Store the maximum of including or skipping the item
                dp[i][j] = max(include, skip);
            }
            else // Invalid Case
            {
                // If the current item cannot be included due to its weight, carry forward the previous value
                dp[i][j] = dp[i - 1][j];
            }
        }
    }

    return dp[n][W];
}

int main()
{
    int W;
    cout << "Enter the capacity of the knapsack: ";
    cin >> W;

    int n;
    cout << "Enter the number of items: ";
    cin >> n;

    vector<pair<int, int>> items;

    cout << "Enter the items in the format {profit, weight}: \n";
    for (int i = 1; i <= n; i++)
    {
        int profit, weight;
        cout << "Item " << i << " : ";
        cin >> profit >> weight;
        items.push_back({profit, weight});
    }

    int maxProfit = ZeroOne_Knapsack(W, n, items);

    cout << "Maximum profit that can be obtained ==>  " << maxProfit << endl;

    return 0;
}

/*
    W = 7
    items = [ {15,2} , {14,5} , {10,1} , {45,3} , {30,4} ]
    ==> 75 
*/