// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/CoinToss.sol";
import "../src/PlayerNFT.sol";

contract CoinTossTest is Test {
    PlayerNFT private playerNFT;

    address private cadenceArch = 0x0000000000000000000000010000000000000001;
    uint64 mockFlowBlockHeight = 12345;
    address user = makeAddr("user");

    function setUp() public {
        // Deploy the CoinToss contract before each test
        playerNFT = new PlayerNFT();
    }

    function testMint() public {
        uint256 nextID = playerNFT.nextTokenId();
        playerNFT.mintPlayer(user, 1, "test");
        assertEq(playerNFT.ownerOf(nextID), user);
    }
}
