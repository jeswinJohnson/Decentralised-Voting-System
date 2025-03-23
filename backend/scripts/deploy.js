const hre = require("hardhat");

async function main() {
    const Contract = await hre.ethers.getContractFactory("Votting");
    const contract_ = await Contract.deploy(1230, 4567, ["0xE652AAC558FdC8feED8C40BAC2CDcdAA44EecedA"], ["party1"]);
    console.log(`Contract deployed at: ${await contract_.getAddress()}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
