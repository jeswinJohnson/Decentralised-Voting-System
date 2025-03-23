// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Votting { 

    struct Candidate {
        string name;
        uint256 voteCount;
    }

    struct ElectionTime {
        uint256 start;
        uint256 end;
    }

    mapping(string => bool) public voters;
    mapping(address => bool) public operators;
    Candidate[] public candidates;

    ElectionTime public electionTime;

    address public owner;

    constructor(uint startTime, uint endTime, address[] memory operatorsList, string[] memory candiateList){

        for (uint256 i = 0; i < operatorsList.length; i++) {
            operators[operatorsList[i]] = true;
        }

        for (uint256 i = 0; i < candiateList.length; i++) {
            candidates.push(Candidate({
                name: candiateList[i],
                voteCount: 0
            }));
        }

        owner = msg.sender;

        electionTime = ElectionTime(
            {
                start: startTime,
                end: endTime
            }
        );
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    modifier onlyOperator {
        require(operators[msg.sender]);
        _;
    }

    function addVote(string memory votter, string memory partyName) public onlyOperator() {
        require(!voters[votter], "Already Voted");

        for(uint256 x = 0; x < candidates.length; x++){
            if (keccak256(abi.encodePacked(candidates[x].name)) == keccak256(abi.encodePacked(partyName))) {
                candidates[x].voteCount++;
                break;
            }
        }
    }

    function addCandidate(string memory candidateName) public onlyOwner {
        candidates.push(Candidate({
            name: candidateName,
            voteCount: 0
        }));
    }

    function addOperator(address operatorId) public onlyOwner {
        operators[operatorId] = true;
    }

    function getVotes() public view returns (Candidate[] memory) {
        return candidates;
    }

    function getElectionTime() view public returns (ElectionTime memory){
        return electionTime;
    }

}
