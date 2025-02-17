// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Staking {
    mapping(address => uint) public stakedBalances;
    mapping(address => uint) public rewardBalances;
    uint public rewardRate = 10; // 10% annual reward
    uint public totalStaked;

    function stake(uint amount) public {
        require(amount > 0, "Amount must be greater than 0");
        stakedBalances[msg.sender] += amount;
        totalStaked += amount;
    }

    function unstake(uint amount) public {
        require(stakedBalances[msg.sender] >= amount, "Insufficient staked balance");
        stakedBalances[msg.sender] -= amount;
        totalStaked -= amount;
        payable(msg.sender).transfer(amount);
    }

    function claimRewards() public {
        uint rewards = (stakedBalances[msg.sender] * rewardRate) / 100;
        rewardBalances[msg.sender] += rewards;
        payable(msg.sender).transfer(rewards);
    }
}