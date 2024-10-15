// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

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

    function testFuzz_Mint(address x) public {
        uint256 nextID = playerNFT.nextTokenId();
        uint256 gasAmountBefore = gasleft();
        playerNFT.mintPlayer(x, 1, "test");
        uint256 gasAmountAfter = gasleft();

        assertEq(playerNFT.ownerOf(nextID), x);
        console.log("Gas Spent:", gasAmountBefore - gasAmountAfter);
    }

    function testGame() public {
        address user1 = makeAddr("user1");
        address user2 = makeAddr("user2");

        playerNFT.mintPlayer(user1, 40, "Jordan");
        playerNFT.mintPlayer(user2, 35, "Lebron");
    }
}
