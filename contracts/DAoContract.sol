// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DAO {
    struct Proposal {
        string description;
        uint voteCount;
        bool executed;
    }

    Proposal[] public proposals;
    mapping(address => bool) public members;
    mapping(uint => mapping(address => bool)) public votes;

    modifier onlyMember() {
        require(members[msg.sender], "Only members can call this function");
        _;
    }

    function addMember(address _member) public onlyMember {
        members[_member] = true;
    }

    function createProposal(string memory _description) public onlyMember {
        proposals.push(Proposal(_description, 0, false));
    }

    function vote(uint proposalId) public onlyMember {
        require(!votes[proposalId][msg.sender], "Already voted");
        votes[proposalId][msg.sender] = true;
        proposals[proposalId].voteCount++;
    }

    function executeProposal(uint proposalId) public onlyMember {
        Proposal storage proposal = proposals[proposalId];
        require(!proposal.executed, "Proposal already executed");
        require(proposal.voteCount > (members.length / 2), "Not enough votes");

        proposal.executed = true;
        // Execute the proposal logic here
    }
}