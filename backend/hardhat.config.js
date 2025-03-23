require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.28",
  networks: {
    ganache: {
      url: "http://127.0.0.1:7545", // Ganache RPC URL
      accounts: [
        "0x98989fe7fbd8d1a20eb1e5e7d9c82319e834be90a86fa414ef90840e8733cdfc",
      ],
    },
  },
};
