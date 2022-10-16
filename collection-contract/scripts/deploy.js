const main = async() => {
  const contractFactory = await hre.ethers.getContractFactory("NFTCollection");
  const nftContract = await contractFactory.deploy();
  await nftContract.deployed();

  console.log("contract deployed at %S", nftContract.address);

  let txn = await nftContract.makeNFT();
  await txn.wait();
  console.log("minted nft#1");

  txn = await nftContract.makeNFT();
  await txn.wait();
  console.log("minted nft#2");
}

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch(error){
    console.log(error);
    process.exit(1);
  }
};
runMain();