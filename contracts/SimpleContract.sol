// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract MyContract {
    unint public MyNumber;

    constructor(uint _initialNumber) {
        myNumber = _initialNumber;
    }

    function setNumber(uint _newNumber) public {
        myNumber = _newNumber;
    }

    function getNumber() public view returns (uint) {
        return myNumber;
    }
}