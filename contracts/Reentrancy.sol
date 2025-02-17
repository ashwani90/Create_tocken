// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ReentrancyGuard {
    bool private locked;

    modifier noReentrancy() {
        require(!locked, "Reentrant call");
        locked = true;
        _;
        locked = false;
    }
}

contract SecureEtherWallet is ReentrancyGuard {
    mapping(address => uint256) public balances;

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 _amount) public noReentrancy {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }
}