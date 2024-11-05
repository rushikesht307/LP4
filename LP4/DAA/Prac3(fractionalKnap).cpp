#include<iostream>
#include<vector>
#include<algorithm>
using namespace std;

// Custom comparator function to sort items based on their profit-to-weight ratio
bool customComparator(pair<int, int>& p1, pair<int, int>& p2) {
    // Calculate the profit-to-weight ratio for both items
    double ratio1 = (double)p1.first / p1.second; // Profit of item 1 / Weight of item 1
    double ratio2 = (double)p2.first / p2.second; // Profit of item 2 / Weight of item 2

    // Sort in descending order based on the ratio
    return ratio1 > ratio2; // Return true if ratio1 is greater than ratio2
}


double fractionalKnapsack(int W, int n, vector<pair<int, int>>& items) {
    // Sort items based on their profit-to-weight ratio in decreasing order
    sort(items.begin(), items.end(), customComparator);

    double result = 0.0;

    for (auto item : items) {
        int currProfit = item.first;  
        int currWeight = item.second;  

        // Check if the current item can be fully accommodated in the knapsack
        if (W >= currWeight) {
            // If yes, add the entire profit of the current item
            result += currProfit;
            W -= currWeight; // Decrease the remaining capacity of the knapsack
        } else {
            // If the item can't be fully accommodated, take the fraction of it
            result += ((double)W / currWeight) * currProfit; // Add the fraction of profit
            break; // Since the knapsack is now full, exit the loop
        }
    }

    return result; 
}

int main() {
    int W; 
    cout << "Enter the capacity of the knapsack: ";
    cin >> W; 

    int n; 
    cout << "Enter the number of items: ";
    cin >> n; 

    vector<pair<int, int>> items;

    cout << "Enter the items in the format {profit, weight}: \n";
    for (int i = 1; i <= n; i++) {
        int profit, weight; 
        cout << "Item " << i << " : ";
        cin >> profit >> weight; 
        items.push_back({profit, weight});
    }

    cout << "\nTotal Profit => " << fractionalKnapsack(W, n, items) << endl;

    return 0; 
}


/*

    Fractional Knapsack Problem using Greedy Algorithm:
    The basic idea of the greedy approach is to calculate the ratio profit/weight for each item and 
    sort the item on the basis of this ratio. 
    Then take the item with the highest ratio and add them as much as we can (can be the whole element or a fraction of it).

    This will always give the maximum profit because, in each step it adds an element such that 
    this is the maximum possible profit for that much weight.

    Time Complexity
    ==> Sorting the Items ( O(nlogn) ) + Iterating Through the Items ( O(n)) 
    Total Time Complexity = O(nlogn)
*/