//script for compile - deploy - execute
const main = async () => {
    //create random user with hardhat
    //owner => the wallet address of contract owner (person deploy the contract)
    //randomPerson => a random wallet addres
    const [owner, randomPerson] = await hre.ethers.getSigners()
    //compile
    const waveContractFactory = await hre.ethers.getContractFactory('WavePortal');
    //deploy
    const waveContract = await waveContractFactory.deploy({
      value: hre.ethers.utils.parseEther('0.1') //add ETH to contract
    });
    await waveContract.deployed();
    //print address SmartContract when it's deploy
    console.log("Contract deployed to:", waveContract.address);
    //print address user owner wallet 
    console.log("Owner address :", owner.address);

    //check contract balance
    let contractBalance = await hre.ethers.provider.getBalance(
      waveContract.address
    );
    console.log(
      'Contract balance:',
      hre.ethers.utils.formatEther(contractBalance)
    );

    //Call function
    let waveCount;
    waveCount = await waveContract.getTotalWaves();
    console.log(waveCount.toNumber());

    //send waves
    let waveTxn = await waveContract.wave("A message random");
    await waveTxn.wait();
    //same address
    waveTxn = await waveContract.wave("A message random same address SPAM");
    await waveTxn.wait();
    //new address
    waveTxn = await waveContract.connect(randomPerson).wave("Another message random, new address");
    await waveTxn.wait();

    //another check balance see withdraw or not
    contractBalance = await hre.ethers.provider.getBalance(waveContract.address);
    console.log(
      'Contract balance:',
      hre.ethers.utils.formatEther(contractBalance)
    );

    //recover allwaves
    waveCount = await waveContract.getTotalWaves();
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