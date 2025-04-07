require("@nomicfoundation/hardhat-toolbox");

module.exports = {
  solidity: "0.8.28",
  networks: {
    ganache: {
      url: "Ganache RPC URL", // Ganache RPC URL
      accounts: [
        "ECI PRIVATE KEY",
      ],
    },
  },
};
