// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DEX {
    mapping(address => mapping(address => uint)) public liquidityPool;
    uint public exchangeRate = 100; // 1 TokenA = 100 TokenB

    function addLiquidity(address tokenA, address tokenB, uint amountA, uint amountB) public {
        liquidityPool[tokenA][tokenB] += amountA;
        liquidityPool[tokenB][tokenA] += amountB;
    }

    function swap(address tokenA, address tokenB, uint amountA) public {
        uint amountB = (amountA * exchangeRate) / 100;
        require(liquidityPool[tokenB][tokenA] >= amountB, "Insufficient liquidity");
        liquidityPool[tokenA][tokenB] += amountA;
        liquidityPool[tokenB][tokenA] -= amountB;
        // Transfer tokens (implementation omitted for simplicity)
    }
}