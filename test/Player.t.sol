// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/ShootOff.sol";
import "../src/PlayerNFT.sol";

contract CoinTossTest is Test {
    PlayerNFT private playerNFT;
    ShootOff private shootOff;
    address private cadenceArch = 0x0000000000000000000000010000000000000001;
    uint64 mockFlowBlockHeight = 12345;
    address user = makeAddr("user");

    function setUp() public {
        // Deploy the CoinToss contract before each test
        playerNFT = new PlayerNFT();
        shootOff = new ShootOff(address(playerNFT));
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
        vm.mockCall(
            cadenceArch,
            abi.encodeWithSignature("flowBlockHeight()"),
            abi.encode(mockFlowBlockHeight)
        );

        // Mock the Cadence Arch precompile for getRandomSource(uint64) call
        vm.mockCall(
            cadenceArch,
            abi.encodeWithSignature("getRandomSource(uint64)", 100),
            abi.encode(uint64(0))
        );

        address user1 = makeAddr("user1");
        address user2 = makeAddr("user2");

        uint256 user1ID = playerNFT.nextTokenId();
        playerNFT.mintPlayer(user1, 100, "Jordan");

        uint256 user2ID = playerNFT.nextTokenId();
        playerNFT.mintPlayer(user2, 10, "Lebron");

        vm.prank(user1);
        shootOff.joinGame(user1ID);

        vm.prank(user2);
        shootOff.joinGame(user2ID);

        vm.prank(user2);
        shootOff.shootOff();

        vm.mockCall(
            cadenceArch,
            abi.encodeWithSignature("flowBlockHeight()"),
            abi.encode(mockFlowBlockHeight + 1)
        );
        vm.mockCall(
            cadenceArch,
            abi.encodeWithSignature(
                "getRandomSource(uint64)",
                mockFlowBlockHeight
            ),
            abi.encode(
                bytes32(
                    0xff00000000000000000000000000000000000000000000000000000000000001
                )
            )
        );
        vm.prank(user2);
        shootOff.shootBalls();
        console.log("Winner:", shootOff.winner());
    }
}
