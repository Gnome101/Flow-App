// // SPDX-License-Identifier: MIT
// pragma solidity 0.8.19;

// import "../src/CoinToss.sol"; // Assuming you have the CoinToss contract in the same directory
// import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
// import {Script} from "forge-std/Script.sol";

// contract CoinFlipScript is Script {
//     CoinToss private coinToss;

//     address payable user;
//     address private cadenceArch = 0x0000000000000000000000010000000000000001;
//     uint64 mockFlowBlockHeight = 12345;

//     function run() public {
//         uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
//         address contractAddress = DevOpsTools.get_most_recent_deployment(
//             "CoinToss",
//             block.chainid
//         );
//         coinToss = CoinToss(payable(contractAddress)); // Provide CoinToss contract address
//         address payable _to = payable(address(coinToss));
//         vm.startBroadcast(deployerPrivateKey);

//         (bool sent /*bytes memory data*/, ) = _to.call{value: 0.01 ether}("");
//         require(sent, "Failed to send Ether");

//         uint256 betAmount = 0.01 ether; // The amount the user will bet on the coin toss

//         // Step 1: Flip the coin by calling flipCoin with 1 Ether
//         // coinToss.flipCoin{value: betAmount}();

//         vm.stopBroadcast();
//     }
// }
