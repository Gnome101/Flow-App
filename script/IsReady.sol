// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "../src/CoinToss.sol"; // Assuming you have the CoinToss contract in the same directory
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";
import {Script, console} from "forge-std/Script.sol";

contract CoinFlipScript is Script {
    CoinToss private coinToss;

    address payable user;
    address private cadenceArch = 0x0000000000000000000000010000000000000001;
    uint64 mockFlowBlockHeight = 12345;

    function run() public {
        address contractAddress = DevOpsTools.get_most_recent_deployment(
            "CoinToss",
            block.chainid
        );
        coinToss = CoinToss(payable(contractAddress)); // Provide CoinToss contract address
        uint256 requestID = coinToss.coinTosses(msg.sender);
        console.log(contractAddress);
        console.log(coinToss.canFulfillRequest(1));
    }
}
