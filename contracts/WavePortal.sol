// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    //variable contract call state variable and save permanently inside the contract
    uint256 totalWaves;
    address senderAddress;

    constructor() {
        console.log("Yo yo, My first Contract Smart or Smart Contract");
    }

    //function public
    function wave() public {
        totalWaves+=1;
        senderAddress = msg.sender;
        //call variable inside print %s.... , variable
        //msg.sender c'est l'addresse de la personne qui appel la fonction, le wallet
        console.log("%s has saved on chain", msg.sender);
    }

    //function with a return 
    function getTotalWaves() public view returns (uint256) {
        console.log("We have %d waves", totalWaves);
        console.log("And address =>  %d", senderAddress);
        return totalWaves;
    }
}