require("dotenv").config();
const { ethers } = require("ethers");
const express = require('express')
const cors = require('cors')

// Express Configs
const app = express()
const port = 3000
app.use(cors("*"))

// Load environment variables
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const RPC_URL = process.env.RPC_URL;
const CONTRACT_ADDRESS = process.env.CONTRACT_ADDRESS;

// Contract ABI
const CONTRACT_ABI = [
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "startTime",
                "type": "uint256"
        },
            {
                "internalType": "uint256",
                "name": "endTime",
                "type": "uint256"
        },
            {
                "internalType": "address[]",
                "name": "operatorsList",
                "type": "address[]"
        },
            {
                "internalType": "string[]",
                "name": "candiateList",
                "type": "string[]"
        }
        ],
        "stateMutability": "nonpayable",
        "type": "constructor"
    },
    {
        "inputs": [
            {
                "internalType": "string",
                "name": "candidateName",
                "type": "string"
        }
        ],
        "name": "addCandidate",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "operatorId",
                "type": "address"
        }
        ],
        "name": "addOperator",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "string",
                "name": "votter",
                "type": "string"
        },
            {
                "internalType": "string",
                "name": "partyName",
                "type": "string"
        }
        ],
        "name": "addVote",
        "outputs": [],
        "stateMutability": "nonpayable",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
        }
        ],
        "name": "candidates",
        "outputs": [
            {
                "internalType": "string",
                "name": "name",
                "type": "string"
        },
            {
                "internalType": "uint256",
                "name": "voteCount",
                "type": "uint256"
        }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "electionTime",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "start",
                "type": "uint256"
        },
            {
                "internalType": "uint256",
                "name": "end",
                "type": "uint256"
        }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getElectionTime",
        "outputs": [
            {
                "components": [
                    {
                        "internalType": "uint256",
                        "name": "start",
                        "type": "uint256"
            },
                    {
                        "internalType": "uint256",
                        "name": "end",
                        "type": "uint256"
            }
                ],
                "internalType": "struct Votting.ElectionTime",
                "name": "",
                "type": "tuple"
        }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "getVotes",
        "outputs": [
            {
                "components": [
                    {
                        "internalType": "string",
                        "name": "name",
                        "type": "string"
            },
                    {
                        "internalType": "uint256",
                        "name": "voteCount",
                        "type": "uint256"
            }
                ],
                "internalType": "struct Votting.Candidate[]",
                "name": "",
                "type": "tuple[]"
        }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
        }
        ],
        "name": "operators",
        "outputs": [
            {
                "internalType": "bool",
                "name": "",
                "type": "bool"
        }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [],
        "name": "owner",
        "outputs": [
            {
                "internalType": "address",
                "name": "",
                "type": "address"
        }
        ],
        "stateMutability": "view",
        "type": "function"
    },
    {
        "inputs": [
            {
                "internalType": "string",
                "name": "",
                "type": "string"
        }
        ],
        "name": "voters",
        "outputs": [
            {
                "internalType": "bool",
                "name": "",
                "type": "bool"
        }
        ],
        "stateMutability": "view",
        "type": "function"
    }
];





// Connect to Ethereum network
const provider = new ethers.JsonRpcProvider(RPC_URL);
const wallet = new ethers.Wallet(PRIVATE_KEY, provider);

// Connect to deployed contract
const contract = new ethers.Contract(CONTRACT_ADDRESS, CONTRACT_ABI, wallet);

async function main(){
    console.log(await contract.candidates())
    const tx = await contract.addCandidate("party2");
    await tx.wait();
    // console.log(await contract.candidates)
}

main()