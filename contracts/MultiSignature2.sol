// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TimeLockedMultiSigWallet {
    address[] public owners;
    uint public required;
    uint public delay;

    struct Transaction {
        address to;
        uint value;
        bool executed;
        uint timestamp;
    }

    Transaction[] public transactions;
    mapping(uint => mapping(address => bool)) public approvals;

    modifier onlyOwner() {
        bool isOwner = false;
        for (uint i = 0; i < owners.length; i++) {
            if (owners[i] == msg.sender) {
                isOwner = true;
                break;
            }
        }
        require(isOwner, "Only owner can call this function");
        _;
    }

    constructor(address[] memory _owners, uint _required, uint _delay) {
        require(_owners.length > 0, "At least one owner required");
        require(_required > 0 && _required <= _owners.length, "Invalid required number of approvals");

        owners = _owners;
        required = _required;
        delay = _delay;
    }

    function submitTransaction(address to, uint value) public onlyOwner {
        transactions.push(Transaction(to, value, false, block.timestamp + delay));
    }

    function approveTransaction(uint txId) public onlyOwner {
        require(!transactions[txId].executed, "Transaction already executed");
        require(block.timestamp >= transactions[txId].timestamp, "Transaction is time-locked");

        approvals[txId][msg.sender] = true;

        uint approvalCount = 0;
        for (uint i = 0; i < owners.length; i++) {
            if (approvals[txId][owners[i]]) {
                approvalCount++;
            }
        }

        if (approvalCount >= required) {
            transactions[txId].executed = true;
            payable(transactions[txId].to).transfer(transactions[txId].value);
        }
    }
}