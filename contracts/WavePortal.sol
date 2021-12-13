// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    //variable contract call state variable and save permanently inside the contract
    uint256 totalWaves;
    address senderAddress;
    uint256 private seed; //generate random number

    event NewWave(address indexed from, uint256 timestamp, string message);

    //basicly the wave model
    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
    }

    //variable who save waves
    Wave[] waves;

    //map addresse user + timestamp last wave
    mapping(address => uint256) public lastWavedAt;

    //payable allow contract to send money
    constructor() payable {
        console.log("Yo yo, My first Contract Smart or Smart Contract");
        //init value
        seed = (block.timestamp + block.difficulty) % 100;
    }

    //function public
    function wave(string memory _message) public {
        //check when this addresse sned last waved
        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp, 
            "You need to wait 15 min"
        );
        console.log("sender time %s", block.timestamp);

        //add or update current timestamp of this wave for this addresse
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves+=1;
        senderAddress = msg.sender;
        //call variable inside print %s.... , variable
        //msg.sender c'est l'addresse de la personne qui appel la fonction, le wallet
        console.log("%s waved has saved on chain & messages => %s", msg.sender, _message);
        //save wave in the array
        waves.push(Wave(msg.sender, _message, block.timestamp));

        //generate new seed for each wave
        seed = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %d", seed);

        //% user win
        if(seed <= 50){ //50% de win
            console.log("%s you win!!!!!", msg.sender);   
            //send Eth to user
            uint256 prizeAmount = 0.0001 ether;
            //check balance account
            require(
                prizeAmount <= address(this).balance, //prize superior of the contract balance
                "Sorry contract doesn't have enougth ETH"
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}(""); //weird synstax but is to validate the sending
            require(success, "Faile to widthdraw ETH from contract");
        }

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