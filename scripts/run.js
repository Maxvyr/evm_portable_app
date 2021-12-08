//script for compile - deploy - execute
const main = async () => {
    //compile
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
    //deploy
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
    //git address SmartContract when it's deploy
    console.log("Contract deployed to:", waveContract.address);
  };
  
  const runMain = async () => {
    try {
      await main();
      process.exit(0);
    } catch (error) {
      console.log(error);
      process.exit(1);
    }
  };
  
  runMain();