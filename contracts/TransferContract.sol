// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EtherWallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    // Deposit Ether into the contract
    function deposit() public payable {}

    // Withdraw Ether from the contract (only owner)
    function withdraw(uint amount) public {
        require(msg.sender == owner, "Only owner can withdraw");
        payable(msg.sender).transfer(amount);
    }

    // Get the contract's balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}