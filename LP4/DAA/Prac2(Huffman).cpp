#include<iostream>
#include<vector>
#include <unordered_map>
#include<queue>
using namespace std;

// Node class to represent a node in the Huffman Tree
class Node{
    public :
        char ch;     // Character
        int freq;    // Frequency of the character
        Node* left;  // Left child pointer
        Node* right; // Right child pointer

    // Constructor for creating a node with a given character and frequency
    Node(char c , int f){
        ch = c;
        freq = f;
        left = right = NULL;
    }
};

void printCodes(Node* root, string str, unordered_map<char, string> &huffmanCodes) {
    if (root == NULL)
        return;

    // If it's a leaf node, assign the current binary string 'str' as the Huffman code
    if (root->left == NULL && root->right == NULL) {
        huffmanCodes[root->ch] = str;
        cout << root->ch << " : " << str << endl;
    }

    // Recursive call to the left subtree and append "0" to the code
    printCodes(root->left, str + "0", huffmanCodes);
    
    // Recursive call to the right subtree and append "1" to the code
    printCodes(root->right, str + "1", huffmanCodes);
}

// Custom comparator function for the priority queue to order nodes by their frequency
// It returns true if the left node's frequency is greater than the right node's frequency
bool customComparator(Node* left , Node* right){
    return left->freq > right->freq;
}


void huffmanEncoding(vector<char>& chars, vector<int>& freqs, int n) {
    // Priority queue (min-heap) to store nodes of the Huffman Tree in increasing order of frequency
    priority_queue<Node*, vector<Node*>, decltype(&customComparator)> minHeap(customComparator);

    // Step 1: Insert all characters and their frequencies into the min-heap as nodes
    for(int i = 0; i < n; i++){
        // Create new node for each character and its corresponding frequency 
        Node* node = new Node(chars[i], freqs[i]);

        // insert this node in minheap
        minHeap.push(node);
    }

    // Step 2: Build the Huffman Tree by combining the two smallest frequency nodes at a time
    while(minHeap.size() != 1){
        // Extract the two nodes with the smallest frequencies
        Node* left = minHeap.top();
        minHeap.pop();

        Node* right = minHeap.top();
        minHeap.pop();

        // Create a new internal node with frequency equal to the sum of the two smallest frequencies
        // This new node's children are the two extracted nodes
        Node* newnode = new Node('\0', left->freq + right->freq);
        newnode->left = left;
        newnode->right = right;

        // Insert the new node back into the min-heap
        minHeap.push(newnode);
    }

    // The last node remaining in the min-heap is the root of the Huffman Tree
    Node* root = minHeap.top();

    // Step 3: Traverse the Huffman Tree and generate the Huffman codes
    unordered_map<char, string> huffmanCodes;
    printCodes(root, "", huffmanCodes);  
}

int main(){
    // Input the number of characters
    int n;
    cout << "Enter the number of characters: ";
    cin >> n;

    vector<char> chars(n);   // Vector to store the characters
    vector<int> freqs(n);    // Vector to store the frequencies of the characters

    // Input the characters and their respective frequencies
    cout << "Enter the characters and their frequencies:\n";
    for (int i = 0; i < n; i++) {
        cout << "Character " << i + 1 << ": ";
        cin >> chars[i];
        cout << "Frequency: ";
        cin >> freqs[i];
    }

    // Call the Huffman Encoding function
    huffmanEncoding(chars, freqs, n);

    return 0;
}
