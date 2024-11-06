// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BankAccount {
    address public owner;
    uint256 private balance;

    // Modifier to ensure that only the owner can perform certain actions
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    // Constructor to set the contract deployer as the owner
    constructor() {
        owner = msg.sender;
        balance = 0;
    }

    // Function to deposit money into the account
    function deposit() public payable {
        require(msg.value > 0, "Deposit value must be greater than 0");
        balance += msg.value;
    }

    // Function to withdraw money from the account
    function withdraw(uint256 amount) public onlyOwner {
        require(amount <= balance, "Insufficient balance");
        balance -= amount;

        // Transfer the requested amount to the owner
        payable(msg.sender).transfer(amount);
    }

    // Function to check the balance
    function getBalance() public view returns (uint256) {
        return balance;
    }
}






/*

1. License and Version
solidity
Copy code
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
	•	// SPDX-License-Identifier: MIT: This is the license type (MIT in this case) for the contract.
	•	pragma solidity ^0.8.0;: This line specifies the Solidity compiler version you're using, which is 0.8.0 or higher. It helps ensure the contract will work with compatible versions of the Solidity compiler.

2. Contract Definition
solidity
Copy code
contract BankAccount {
    address public owner;
    uint256 private balance;
	•	contract BankAccount {}: This defines a new contract called BankAccount. Inside this contract is where we define the behavior and data for the "bank account."
	•	address public owner;: This defines a variable called owner, which is of type address. In Solidity, address is a 20-byte value that represents a user or smart contract address on the Ethereum network. The keyword public makes the owner variable accessible from outside the contract.
	•	uint256 private balance;: This defines a balance variable to store the Ether balance in the contract. uint256 is an unsigned integer (a whole number that can’t be negative). The private keyword means that balance can only be accessed within this contract (not externally).

3. Modifier
solidity
Copy code
modifier onlyOwner() {
    require(msg.sender == owner, "Only the owner can perform this action");
    _;
}
	•	Modifiers in Solidity are like functions but are used to add checks or conditions to other functions. This onlyOwner modifier ensures that only the contract owner can run specific functions.
	•	require(msg.sender == owner, "Only the owner can perform this action");: The require() function checks that the condition is true (here, whether msg.sender—the person calling the function—is the owner). If the condition is false, it reverts the transaction with the message: "Only the owner can perform this action."
	•	_: The _ symbol tells Solidity to continue executing the rest of the function where the modifier is applied.

4. Constructor (Setting the Owner)
solidity
Copy code
constructor() {
    owner = msg.sender;
    balance = 0;
}
	•	Constructor: This special function is executed only once when the contract is deployed on the blockchain.
	•	owner = msg.sender;: The msg.sender is the Ethereum address that deployed the contract. Here, the constructor sets the owner variable to the address of the person (or entity) that deploys the contract.
	•	balance = 0;: It initializes the balance to zero when the contract is first deployed.

5. Deposit Function
solidity
Copy code
function deposit() public payable {
    require(msg.value > 0, "Deposit value must be greater than 0");
    balance += msg.value;
}
	•	Deposit Function: This function allows anyone to deposit Ether (Ethereum’s currency) into the contract.
	•	public payable: The public keyword means anyone can call this function. payable allows the function to receive Ether.
	•	msg.value: This is the amount of Ether sent along with the transaction. It is automatically passed to the function.
	•	balance += msg.value;: This adds the sent Ether (msg.value) to the balance of the contract.

6. Withdraw Function
solidity
Copy code
function withdraw(uint256 amount) public onlyOwner {
    require(amount <= balance, "Insufficient balance");
    balance -= amount;
    payable(msg.sender).transfer(amount);
}
	•	Withdraw Function: This function allows the owner to withdraw Ether from the contract.
	•	onlyOwner: This uses the previously defined onlyOwner modifier, so only the contract owner can call this function.
	•	require(amount <= balance, "Insufficient balance");: This checks if the requested withdrawal amount is less than or equal to the contract’s balance. If not, the transaction is reverted with the message "Insufficient balance."
	•	payable(msg.sender).transfer(amount);: The transfer() function sends the specified amount of Ether back to the contract owner (msg.sender). The payable keyword ensures the transfer of Ether.

7. Get Balance Function
solidity
Copy code
function getBalance() public view returns (uint256) {
    return balance;
}
	•	Get Balance Function: This is a public function that anyone can call to check the current balance of the contract.
	•	view: This keyword indicates that this function will only read from the blockchain, not modify it. No gas is spent when calling view functions.
	•	returns (uint256): This specifies that the function returns a uint256 type (which is the balance).

Full Contract Summary
	•	Owner Control: Only the person who deployed the contract can withdraw funds.
	•	Deposit: Anyone can send Ether to the contract.
	•	Withdraw: Only the owner can withdraw the Ether stored in the contract.
	•	Check Balance: Anyone can view the contract’s balance.

Deploying and Testing
Once the contract is deployed, you can interact with it using tools like Remix or command-line tools like Hardhat and Truffle. When you:
	•	Call the deposit() function, you send Ether to the contract.
	•	Call withdraw(), and the contract sends Ether back to the owner.
	•	Call getBalance(), and it will show the current Ether balance stored in the contract.
*/
