import { ethers } from "hardhat";

async function main() {
  const GOERLI_ETH_USD_PRICE_FEED_CONTRACT =
    "0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e";

  const FundMe = await ethers.getContractFactory("FundMe");
  const fundMe = await FundMe.deploy(GOERLI_ETH_USD_PRICE_FEED_CONTRACT);

  await fundMe.deployed();

  console.log(`FundMe deployed to ${fundMe.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
