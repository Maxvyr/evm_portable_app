// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    //variable contract call state variable and save permanently inside the contract
    uint256 totalWaves;
    address senderAddress;

    event NewWave(address indexed from, uint256 timestamp, string message);

    //basicly the wave model
    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    //variable who save waves
    Wave[] waves;

    constructor() {
        console.log("Yo yo, My first Contract Smart or Smart Contract");
    }

    //function public
    function wave(string memory _message) public {
        totalWaves+=1;
        senderAddress = msg.sender;
        //call variable inside print %s.... , variable
        //msg.sender c'est l'addresse de la personne qui appel la fonction, le wallet
        console.log("%s waved has saved on chain & messages => %s", msg.sender, _message);
        //save wave in the array
        waves.push(Wave(msg.sender, _message, block.timestamp));
        //emit 
        emit NewWave(msg.sender, block.timestamp, _message);
    }

    //return array of all waves
    function getAllWaves() public view returns (Wave[] memory){
        return waves;
    }

    //function with a return 
    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d waves", totalWaves);
        console.log("And address =>  %d", senderAddress);
        return totalWaves;
    }
}