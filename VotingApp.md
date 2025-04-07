
## 🗳️ Blockchain Voting System

A secure and transparent voting system built on blockchain to ensure trust, immutability, and decentralization in the electoral process. This project is divided into two Flutter-based applications — one for the Election Commission of India (ECI) and another for Voting Booth Operators — backed by a robust Node.js/Express API and powered by smart contracts using Solidity on Ganache.

### 🔧 Tech Stack

-   **Frontend:** Flutter (for both ECI and Operator apps)
    
-   **Smart Contracts:** Solidity, Ganache (local Ethereum blockchain)
    
-   **Backend:** Node.js with Express.js (RESTful API)
    
-   **Authentication:** Blockchain-based using private/public keys
    

----------

### 📱 Applications Overview

#### 🏛️ ECI App

Designed for the Election Commission and admin-level users. Features include:

-   Adding and managing **voters**
    
-   Adding **candidates**
    
-   Updating **voting timelines**
    
-   Viewing **live results**
    
-   Managing **operator accounts**
    

#### 🧑‍💻 Operator App

Used by voting booth operators. Functionality includes:

-   Logging in with a **blockchain private key** (added by ECI)
    
-   Viewing the list of **registered voters**
    
-   Allowing voters to **cast their votes**
    

----------

### 🧠 How It Works

-   All data interactions (votes, candidate info, etc.) are handled via smart contracts made using Hardhat on a local Ethereum blockchain (Ganache).
    
-   Operators and voters interact with the system through intuitive Flutter apps.
    
-   The backend API acts as a bridge between the apps and the blockchain, ensuring smooth operations and validation using Ethers.js.
    

----------

### 🚀 Getting Started

1.  Start Ganache locally
2. Update the RPC URL and ECI Private Key(The private key of the account you wish to use as ECI account) at `api/hardhat.config.js`
3. Cd into `/api`
4. Run `npm i` to install all packages
5. Run `npx hardhat compile` to compile the smart contract
6. Add a  `.env` file at `/api`
7. Add `RPC_URL=Enter RPC URL` to the `.env` file
8. Run `npx hardhat run scripts/deploy.js --network ganache` to deploy the smart contract
9. Save the smart contract address generated as `CONTRACT_ADDRESS=Enter Contract Address` in the `.env` file   
10. Run `npm run dev` to run the api
    
11.  Launch both Flutter apps (ECI and Operator)
12. Log into the ECI app using the private key used for the contract generation
13. Add Operators by going into the add operator section of ECI app by adding the operator address
14. Log into the Operator app using the private key of the address added in the ECI app
    
15.  Enjoy a secure, tamper-proof voting process!
    

----------

### 📌 Future Enhancements

-   Integration with a public Ethereum testnet or mainnet
    
-   Biometric or Aadhaar-based voter verification
    
-   Real-time analytics and dashboards
