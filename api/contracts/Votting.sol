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

    struct ElectionStatus{
        ElectionTime electionTime;
        uint256 totalVotes;
        Candidate[] candidates;
    }

    struct Votter{
        string userName;
        string userId;
        bool hasVoted;
    }

    struct VotterVisible{
        string userName;
        string userId;
    }

    mapping(string => Votter) public voters;
    VotterVisible[] public votersList;

    mapping(address => bool) public operators;
    Candidate[] public candidates;
    address[] private operatorsList;
    ElectionTime public electionTime;
    

    uint256 public totalVoteCount;
    address public owner;

    constructor(uint startTime, uint endTime, address[] memory passedOperatorsList, string[] memory candiateList){

        for (uint256 i = 0; i < passedOperatorsList.length; i++) {
            operators[passedOperatorsList[i]] = true;
            operatorsList.push(passedOperatorsList[i]);
        }

        for (uint256 i = 0; i < candiateList.length; i++) {
            candidates.push(Candidate({
                name: candiateList[i],
                voteCount: 0
            }));
        }

        owner = msg.sender;
        totalVoteCount = 0;

        electionTime = ElectionTime(
            {
                start: startTime,
                end: endTime
            }
        );
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Eci Operation");
        _;
    }

    modifier onlyOperator {
        require(operators[msg.sender], "Operator Operation");
        _;
    }

    function addVote(string memory votter, string memory partyName) public onlyOperator() {
        require(!voters[votter].hasVoted, "Already Voted");

        for(uint256 x = 0; x < candidates.length; x++){
            if (keccak256(abi.encodePacked(candidates[x].name)) == keccak256(abi.encodePacked(partyName))) {
                candidates[x].voteCount++;
                voters[votter].hasVoted = true;
                totalVoteCount += 1;
                break;
            }
        }
    }

    function addVotter(string memory voterName, string memory voterId) public onlyOwner {

        voters[voterId] = Votter({
                userName: voterName,
                userId: voterId,
                hasVoted: false
            }
        );

        votersList.push(VotterVisible({
           userName: voterName,
            userId: voterId
        }));
    }

    function getVotter() public view returns (VotterVisible[] memory) {
        return votersList;
    }



    function addCandidate(string memory candidateName) public onlyOwner {
        candidates.push(Candidate({
            name: candidateName,
            voteCount: 0
        }));
    }

    function getCandidates() public view returns (Candidate[] memory) {
        return candidates;
    }

    function addOperator(address operatorId) public onlyOwner {
        operators[operatorId] = true;
        operatorsList.push(operatorId);
    }

    function getElectionStatus() public view returns (ElectionStatus memory) {
        return ElectionStatus({
                electionTime: electionTime,
                totalVotes: totalVoteCount,
                candidates: candidates
            }
        );
    }

    function getOperators() public view returns (address[] memory) {
        return operatorsList;
    }

    function getElectionTime() view public returns (ElectionTime memory){
        return electionTime;
    }

    function updateElectionTime(uint256 startTime, uint256 endTime) public onlyOwner() {
        electionTime = ElectionTime({
            start: startTime,
            end: endTime
        });
    }

    function blockTime() view public returns (uint256){
        return block.timestamp;
    }

}
