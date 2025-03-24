require("dotenv").config();
const { ethers } = require("ethers");
const express = require('express')
const cors = require('cors')
const bodyParser = require('body-parser')

// Express Configs
const app = express()
const port = 3000
app.use(cors("*"))
app.use(bodyParser.json())

// Loading Contract Address
const CONTRACT_ADDRESS = process.env.CONTRACT_ADDRESS;

// A random account for endpoints that doesnt need auth
const GenralAccount = "0xbae304e0eaa44de3ea7426146c48161dbf9e2e38034c1d881bd94675e47221ae"

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
        "inputs": [],
        "name": "blockTime",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
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
        "name": "getElectionStatus",
        "outputs": [
            {
                "components": [
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
                        "name": "electionTime",
                        "type": "tuple"
                    },
                    {
                        "internalType": "uint256",
                        "name": "totalVotes",
                        "type": "uint256"
                    },
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
                        "name": "candidates",
                        "type": "tuple[]"
                    }
                ],
                "internalType": "struct Votting.ElectionStatus",
                "name": "",
                "type": "tuple"
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
        "inputs": [],
        "name": "totalVoteCount",
        "outputs": [
            {
                "internalType": "uint256",
                "name": "",
                "type": "uint256"
            }
        ],
        "stateMutability": "view",
        "type": "function"
    },
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
            }
        ],
        "name": "updateElectionTime",
        "outputs": [],
        "stateMutability": "nonpayable",
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
]

// Connect to Ethereum network
const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);

// End-Points
app.get('/getElectionStatus', express.json({ type: '/' }), async (req, res) => {
    const wallet = new ethers.Wallet(GenralAccount, provider);
    const contract = new ethers.Contract(CONTRACT_ADDRESS, CONTRACT_ABI, wallet);
    const [electionTime, totalVotes, candidates] = await contract.getElectionStatus()

    let candidateJson = [];

    candidates.forEach((partyStat) => {
            candidateJson.push({
                "name": partyStat[0],
                "voteCount": Number(partyStat[1])
            })
        }
    );

    res.send({
        "electionStart": Number(electionTime[0]),
        "electionEnd": Number(electionTime[1]),
        "totalVotes": Number(totalVotes),
        "candiates": candidateJson,
    })
})

app.get('/blockTime', express.json({ type: '/' }), async (req, res) => {
    const wallet = new ethers.Wallet(GenralAccount, provider);
    const contract = new ethers.Contract(CONTRACT_ADDRESS, CONTRACT_ABI, wallet);
    const blockTime = await contract.blockTime()
    res.send({
        "electionStart": Number(blockTime),
    })
})

app.get('/getElectionTime', express.json({ type: '/' }), async (req, res) => {
    const wallet = new ethers.Wallet(GenralAccount, provider);
    const contract = new ethers.Contract(CONTRACT_ADDRESS, CONTRACT_ABI, wallet); 
    const [start, end] = await contract.getElectionTime()

    res.send({
        "electionStart": Number(start),
        "electionEnd": Number(end),
    })
})

app.post('/updateElectionTime', express.json({ type: '/' }), async (req, res) => {
    
    if (req.get("key") == undefined || req.get("key") == ""){
        res.send("Invalid Request")
    }else{
        const response = req.body;

        if (response.startTime == undefined || response.endTime == undefined){
            res.send("Invalid Request")
        }else{
            const wallet = new ethers.Wallet(req.get("key"), provider);
            const contract = new ethers.Contract(CONTRACT_ADDRESS, CONTRACT_ABI, wallet);
            try{
                const tx = await contract.updateElectionTime(response.startTime, response.endTime);
                await tx.wait();
                res.send("200")
            } catch(e){
                res.send(e.info.error.data.reason)
            }
        }
    }
})

app.post('/addCandidate', express.json({ type: '/' }), async (req, res) => {

    if (req.get("key") == undefined || req.get("key") == "") {
        res.send("Invalid Request")
    } else {
        const response = req.body;

        if (response.partyName == undefined) {
            res.send("Invalid Request")
        } else {
            const wallet = new ethers.Wallet(req.get("key"), provider);
            const contract = new ethers.Contract(CONTRACT_ADDRESS, CONTRACT_ABI, wallet);
            try {
                const tx = await contract.addCandidate(response.partyName);
                await tx.wait();
                res.send("200")
            } catch (e) {
                res.send(e.info.error.data.reason)
            }
        }
    }
})

app.post('/vote', express.json({ type: '/' }), async (req, res) => {

    if (req.get("key") == undefined || req.get("key") == "") {
        res.send("Invalid Request")
    } else {
        const response = req.body;

        if (response.partyName == undefined || response.voterId == undefined) {
            res.send("Invalid Request")
        } else {
            const wallet = new ethers.Wallet(req.get("key"), provider);
            const contract = new ethers.Contract(CONTRACT_ADDRESS, CONTRACT_ABI, wallet);
            try {
                const tx = await contract.addVote(response.voterId, response.partyName);
                await tx.wait();
                res.send("200")
            } catch (e) {
                res.send(e.info.error.data.reason)
            }
        }
    }
})

app.post('/addOperator', express.json({ type: '/' }), async (req, res) => {

    if (req.get("key") == undefined || req.get("key") == "") {
        res.send("Invalid Request")
    } else {
        const response = req.body;

        if (response.operatorId == undefined) {
            res.send("Invalid Request")
        } else {
            const wallet = new ethers.Wallet(req.get("key"), provider);
            const contract = new ethers.Contract(CONTRACT_ADDRESS, CONTRACT_ABI, wallet);
            try {
                const tx = await contract.addOperator(response.operatorId);
                await tx.wait();
                res.send("200")
            } catch (e) {
                res.send(e.info.error.data.reason)
            }
        }
    }
})

// Exposing
app.listen(port, () => {
    console.log(`Api at http://localhost:${port}/`)
})