// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentData {

    // Structure to store student details
    struct Student {
        string name;
        uint age;
        uint marks;
    }

    // Array to store all student data
    Student[] public students;

    // Event to log new student added
    event StudentAdded(string name, uint age, uint marks);

    // Function to add a new student to the array
    function addStudent(string memory _name, uint _age, uint _marks) public {
        Student memory newStudent = Student(_name, _age, _marks);
        students.push(newStudent);

        // Emit the event
        emit StudentAdded(_name, _age, _marks);
    }

    // Function to get student data by index
    function getStudent(uint _index) public view returns (string memory, uint, uint) {
        require(_index < students.length, "Student does not exist.");
        Student memory student = students[_index];
        return (student.name, student.age, student.marks);
    }

    // Fallback function to handle unexpected calls
    fallback() external payable {
        // Simply accept Ether sent to the contract
    }

    // **New receive function to handle plain Ether transfers**
    receive() external payable {
        // Accept Ether sent to the contract without data
    }

    // Function to view the number of students in the contract
    function getTotalStudents() public view returns (uint) {
        return students.length;
    }
}

/*
    Input : 



    Add Student Data :
    1] "Alice", 21, 85
    2] "Bob", 23, 90
    3] "Charlie", 22, 78



    Get Student Data
    To retrieve a student's data by index, use the getStudent function. For example:
    Input: 0 (to get the first student, which is Alice in this case)

    4. Get Total Students
    To see how many students are currently in the contract, use the getTotalStudents function:
    No input needed, just click the button to get the total number of students.
    Output example: 3 (if you added Alice, Bob, and Charlie)


Code Explanation : 

    Here’s a detailed explanation of each section of the Solidity smart contract you provided:

SPDX License Identifier
solidity
Copy code

This specifies the license under which the contract is distributed. It’s a comment and does not affect the contract's logic. The MIT license is commonly used in open-source projects.

Solidity Version Declaration
solidity
Copy code
pragma solidity ^0.8.0;
This indicates that the contract is written for Solidity version 0.8.0 or higher. The ^ symbol means the contract will work with any version greater than or equal to 0.8.0 but less than 0.9.0.

Contract Definition
solidity
Copy code
contract StudentData {
This starts the definition of the smart contract named StudentData. A smart contract is similar to a class in object-oriented programming.

Struct for Storing Student Details
solidity
Copy code
struct Student {
    string name;
    uint age;
    uint marks;
}
The Student structure is defined to hold individual student details. It contains:

name of type string: A text field for the student's name.
age of type uint: An unsigned integer to store the student's age.
marks of type uint: An unsigned integer to store the student's marks.
Array to Store All Students
solidity
Copy code
Student[] public students;
This creates an array named students that stores multiple Student structures. The public keyword makes the array accessible outside the contract. Solidity will automatically generate a getter function for this array.

Event for Logging
solidity
Copy code
event StudentAdded(string name, uint age, uint marks);
An event is defined to log information when a new student is added. The StudentAdded event takes three parameters: name, age, and marks. When the event is emitted, this data will be stored on the blockchain, and external applications can listen for these events.

Adding a New Student
solidity
Copy code
function addStudent(string memory _name, uint _age, uint _marks) public {
    Student memory newStudent = Student(_name, _age, _marks);
    students.push(newStudent);

    // Emit the event
    emit StudentAdded(_name, _age, _marks);
}
This function allows the user to add a new student:

The function is public, so it can be called by anyone.
It accepts three arguments:
_name: the student's name as a string.
_age: the student's age as an unsigned integer.
_marks: the student's marks as an unsigned integer.
A new Student struct is created using the passed values and pushed into the students array.
The StudentAdded event is emitted to log that a new student was added to the contract.
Getting a Student’s Data by Index
solidity
Copy code
function getStudent(uint _index) public view returns (string memory, uint, uint) {
    require(_index < students.length, "Student does not exist.");
    Student memory student = students[_index];
    return (student.name, student.age, student.marks);
}
This function retrieves a student’s information by their index in the students array:

The require statement checks if the provided index is within the bounds of the array. If the index is invalid, the function throws an error message: "Student does not exist."
If the index is valid, the function returns the student's name, age, and marks.
This function has the view keyword, indicating that it only reads from the blockchain and doesn’t modify any data.
It returns three values: name (string), age (uint), and marks (uint).
Fallback Function
solidity
Copy code
fallback() external payable {
    // Simply accept Ether sent to the contract
}
The fallback function is triggered when the contract is called with data that does not match any function signature. The payable modifier allows the contract to accept Ether (cryptocurrency) through this function. In this case, it does nothing but accept the Ether sent to it.

Receive Function
solidity
Copy code
receive() external payable {
    // Accept Ether sent to the contract without data
}
The receive() function is a special function in Solidity that gets triggered whenever plain Ether is sent to the contract without any data (for example, from a simple transfer). Like the fallback function, it has the payable modifier, meaning it can receive Ether.

Getting the Total Number of Students
solidity
Copy code
function getTotalStudents() public view returns (uint) {
    return students.length;
}
This function returns the total number of students in the contract. It uses the .length property of the students array to determine the number of elements. The function is marked as view since it only reads data without modifying it.

Key Constructs Used
Structures: The struct is used to define a custom data type (Student) to store student-related information (name, age, marks).

Arrays: The students array holds multiple instances of the Student structure, allowing for dynamic storage of student records.

Events: The StudentAdded event is emitted whenever a new student is added. Events are useful for logging and can be listened to by off-chain applications.

Fallback Function: The fallback() function is invoked when an invalid call is made to the contract (e.g., if a function that doesn't exist is called), and in this case, it accepts Ether.

Receive Function: The receive() function allows the contract to accept Ether when it is sent with no data.

Gas and Transaction Fees
When you deploy this contract to an Ethereum test network (like Ropsten or Goerli), you can observe the following:

Gas Fees: Each interaction with the contract (like adding a student or sending Ether) costs gas, which is the fee you pay for using computational power on the blockchain. You can check gas usage on Remix or blockchain explorers.
Transaction Fees: Transaction fees are calculated based on the amount of gas used multiplied by the gas price at the time of the transaction.
The functions addStudent() and getStudent() will consume more gas than getTotalStudents() since they modify the blockchain state or require more complex operations.














*/
