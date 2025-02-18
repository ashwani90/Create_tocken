// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Proxy {
    address public implementation;

    constructor(address _implementation) {
        implementation = _implementation;
    }

    fallback() external payable {
        address _impl = implementation;
        assembly {
            calldatacopy(0, 0, calldatasize())
            let result := delegatecall(gas(), _impl, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch result
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }
}

contract LogicV1 {
    uint256 public value;

    function setValue(uint256 _value) public {
        value = _value;
    }
}

contract LogicV2 {
    uint256 public value;

    function setValue(uint256 _value) public {
        value = _value * 2; // Updated logic
    }
}