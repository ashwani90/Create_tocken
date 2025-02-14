// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

abstract contract Animal {
    string public name;
    uint public age;

    constructor(string memory _name, uint _age) {
        name = _name;
        age = _age;
    }

    function makeSound() public virtual returns (string memory);
}

contract Dog is Animal {
    constructor(string memory _name, uint _age) Animal(_name, _age) {}

    function makeSound() public pure override returns (string memory) {
        return "Woof!";
    }
}

contract Cat is Animal {
    constructor(string memory _name, uint _age) Animal(_name, _age) {}

    function makeSound() public pure override returns (string memory) {
        return "Meow!";
    }
}