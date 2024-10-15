// // SPDX-License-Identifier: MIT
// pragma solidity 0.8.19;

// import {CoinToss} from "../src/CoinToss.sol";
// import {Script} from "forge-std/Script.sol";

// contract DeployCadenceRandomConsumer is Script {
//     CoinToss private coinToss;

//     function deploy() public {
//         coinToss = new CoinToss();
//     }

//     function run() public payable {
//         uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
//         vm.startBroadcast(deployerPrivateKey);
//         deploy();
//         vm.stopBroadcast();
//     }
// }
