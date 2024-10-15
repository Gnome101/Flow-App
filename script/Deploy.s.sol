// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ShootOff} from "../src/ShootOff.sol";
import {Script} from "forge-std/Script.sol";
import {PlayerNFT} from "../src/PlayerNFT.sol";

contract DeployCadenceRandomConsumer is Script {
    ShootOff private shootOff;

    PlayerNFT private playerNFt;

    //0001fadwadadwa
    function deploy() public {
        playerNFt = new PlayerNFT();
        shootOff = new ShootOff(address(playerNFt));
    }

    function run() public payable {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        deploy();
        vm.stopBroadcast();
    }
}
