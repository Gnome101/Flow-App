// // SPDX-License-Identifier: MIT
// pragma solidity ^0.8.20;

// import "../src/CoinToss.sol"; // Assuming you have the CoinToss contract in the same directory
// import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
// import {Script} from "forge-std/Script.sol";

// contract CoinFlipScript is Script {
//     CoinToss private coinToss;

//     address payable user;
//     address private cadenceArch = 0x0000000000000000000000010000000000000001;
//     uint64 mockFlowBlockHeight = 12345;

//     function run() public returns (bool won) {
//         uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
//         address contractAddress = DevOpsTools.get_most_recent_deployment(
//             "CoinToss",
//             block.chainid
//         );
//         coinToss = CoinToss(payable(contractAddress)); // Provide CoinToss contract address
//         vm.startBroadcast(deployerPrivateKey);

//         uint256 initialBalance = user.balance;

//         coinToss.revealCoin();
//         vm.stopBroadcast();

//         // Step 4: Check the final balance of the user
//         uint256 finalBalance = user.balance;

//         // Step 5: Determine if the user won by comparing the final balance
//         if (finalBalance > initialBalance) {
//             return true; // User won (balance increased)
//         } else {
//             return false; // User lost (balance stayed the same or decreased)
//         }
//     }
// }
