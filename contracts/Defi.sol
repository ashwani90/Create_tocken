// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LendingPool {
    mapping(address => uint) public balances;
    uint public totalLiquidity;
    uint public interestRate = 10; // 10% annual interest

    function deposit() public payable {
        balances[msg.sender] += msg.value;
        totalLiquidity += msg.value;
    }

    function withdraw(uint amount) public {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        totalLiquidity -= amount;
        payable(msg.sender).transfer(amount);
    }

    function borrow(uint amount) public {
        require(totalLiquidity >= amount, "Insufficient liquidity");
        uint interest = (amount * interestRate) / 100;
        totalLiquidity -= amount;
        balances[msg.sender] += amount;
        payable(msg.sender).transfer(amount);
    }

    function repay() public payable {
        uint repayment = msg.value;
        balances[msg.sender] -= repayment;
        totalLiquidity += repayment;
    }
}