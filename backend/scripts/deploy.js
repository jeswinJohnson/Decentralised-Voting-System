const hre = require("hardhat");

async function main() {
    const Contract = await hre.ethers.getContractFactory("Votting");
  const contract_ = await Contract.deploy(10, 50, [], []);
    console.log(`Contract deployed at: ${await contract_.getAddress()}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
