//script for compile - deploy - execute
const main = async () => {
    //create random user with hardhat
    //owner => the wallet address of contract owner (person deploy the contract)
    //randomPerson => a random wallet addres
    const [owner, randomPerson] = await hre.ethers.getSigners()
    //compile
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
    //deploy
    const waveContract = await waveContractFactory.deploy();
    await waveContract.deployed();
    //print address SmartContract when it's deploy
    console.log("Contract deployed to:", waveContract.address);
    //print address user owner wallet 
    console.log("Owner address :", owner.address);

    //Call function
    let waveCount;
    waveCount = await waveContract.getTotalWaves();
    console.log(waveCount.toNumber());

    //send waves
    let waveTxn = await waveContract.wave("A message random");
    await waveTxn.wait();

    waveTxn = await waveContract.connect(randomPerson).wave("Another message random");
    await waveTxn.wait();

    waveCount = await waveContract.getTotalWaves();
    //recover allwaves
    let allWaves = await waveContract.getAllWaves();
    console.log("Total :", waveCount);
    console.log("Value : ",allWaves);


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