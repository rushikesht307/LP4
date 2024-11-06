// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BankAccount {
  address public accountholder;
    constructor()
    {
  accountholder=msg.sender;
    }

//0xf8e81D47203A594245E36C48e151709F0C19fBe8
   uint256 balance=0;
   function deposite()public payable 
   {
    require(msg.value > 0, "Deposite amount should be greater than 0");
    require(msg.sender==accountholder,"you are not account owner");
    balance +=msg.value;
   }
   function withdraw() payable public {
        require(balance > 0, "Withdrawal amount should be greater than zero");
        require(msg.sender==accountholder,"you are not account owner");
        payable(msg.sender).transfer(balance);
        balance = 0;
    }
   function showbalance() public view returns(uint)
   {
 require(msg.sender==accountholder,"you are not account owner");
return balance;
   }
}
