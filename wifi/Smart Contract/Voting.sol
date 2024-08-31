// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Voting {
    struct Candidate {
        uint id;
        string name;
        uint votes;
    }

    struct Vote {
        uint candidateId;
        string electionName;
        string candidateName;
        string userName;
    }

    mapping(uint => Candidate) public candidates;
    mapping(uint => mapping(address => bool)) public hasVotedForCandidate;
    mapping(uint => mapping(address => bool)) public hasVotedInElection;
    mapping(address => uint) public votesByUser;
    mapping(uint => mapping(address => Vote)) public votes;

    uint public candidatesCount;
    uint public totalVotes;

    constructor() {
        candidatesCount = 0;
        totalVotes = 0;
    }

    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint _candidateId, string memory _electionName, string memory _userName, string memory _candidateName) public {
        require(!hasVotedInElection[_candidateId][msg.sender], "You have already voted for this election");

        candidates[_candidateId].votes++;
        totalVotes++;

        hasVotedForCandidate[_candidateId][msg.sender] = true;
        hasVotedInElection[_candidateId][msg.sender] = true;

        votesByUser[msg.sender]++;
        votes[_candidateId][msg.sender] = Vote(_candidateId, _electionName, _candidateName, _userName);
    }
}
