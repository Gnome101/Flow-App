// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {CadenceRandomConsumer} from "./CadenceRandomConsumer.sol";
import {PlayerNFT} from "./PlayerNFT.sol";

/**
 * @dev This contract is a simple coin toss game where users can place win prizes by flipping a coin as a demonstration
 * of safe usage of Flow EVM's native secure randomness.
 */
contract CoinToss is CadenceRandomConsumer {
    PlayerNFT public PlayerContract;

    constructor(address _playerContract) {
        PlayerContract = PlayerNFT(_playerContract);
    }

    // A constant to store the multiplier for the prize
    uint8 public constant multiplier = 2;

    // A mapping to store the request ID for each user
    mapping(address => uint256) public coinTosses;
    // A mapping to store the value sent by the user for each request
    mapping(uint256 => uint256) public openRequests;

    event CoinFlipped(
        address indexed user,
        uint256 indexed requestId,
        uint256 amount
    );
    event CoinRevealed(
        address indexed user,
        uint256 indexed requestId,
        uint8 coinFace,
        uint256 prize
    );

    /**
     * @dev Checks if a user has an open request.
     */
    function hasOpenRequest(address user) public view returns (bool) {
        return coinTosses[user] != 0;
    }

    uint256 player1;
    uint256 player2;
    uint256 requestId;

    uint256 winner;

    function joinGame(uint256 playerNFTID) public {
        require(PlayerContract.ownerOf(playerNFTID) == msg.sender, "Not Owner");
        if (player1 == 0) {
            player1 = playerNFTID;
        } else if (player2 == 0) {
            player2 = playerNFTID;
        } else {
            revert(" 2 Players Already Chosen");
        }
    }

    /**
     * @dev Allows a user to flip a coin by sending FLOW to the contract. This is the commit step in the commit-reveal scheme.
     */
    function shootOff() public payable {
        require(
            PlayerContract.ownerOf(player1) == msg.sender ||
                PlayerContract.ownerOf(player2) == msg.sender,
            "Player Must Be Caller"
        );

        // require(_isNonZero(msg.value), "Must send FLOW to place flip a coin");
        require(
            !_isNonZero(coinTosses[msg.sender]),
            "Must close previous coin flip before placing a new one"
        );

        // request randomness
        requestId = _requestRandomness();
        // insert the request ID into the coinTosses mapping
        coinTosses[msg.sender] = requestId;
        // insert the value sent by the sender with the flipCoin function call into the openRequests mapping
        openRequests[requestId] = msg.value;

        emit CoinFlipped(msg.sender, requestId, msg.value);
    }

    /**
     * @dev Allows a user to reveal the result of the coin flip and claim their prize.
     */
    function shootBalls() public {
        require(
            hasOpenRequest(msg.sender),
            "Caller has not flipped a coin - nothing to reveal"
        );

        // reveal random result and calculate winnings
        // uint256 requestId = coinTosses[msg.sender];
        // delete the open request from the coinTosses mapping
        delete coinTosses[msg.sender];

        // fulfill the random request within the inclusive range [0, 1]
        // NOTE: Could use % 2 without risk of modulo bias since the range is a multiple of the modulus
        //  but using _fulfillRandomInRange for demonstration purposes
        uint8 rand = uint8(_fulfillRandomInRange(requestId, 0, 100));

        // get the value sent in the flipCoin function & remove the request from the openRequests mapping
        uint256 amount = openRequests[requestId];
        delete openRequests[requestId];

        uint256 player1Probability = PlayerContract.playerShootingProbability(
            player1
        );
        uint256 shotScore1 = uint256(keccak256(abi.encodePacked(rand)));
        shotScore1 = shotScore1 % 100;

        uint256 shotScore2 = uint256(keccak256(abi.encodePacked(rand + 2)));
        shotScore2 = shotScore2 % 100;

        uint256 player2Probability = PlayerContract.playerShootingProbability(
            player2
        );
        bool player1Wins = player1Probability * shotScore1 >
            player2Probability * shotScore2;
        // if(player1Probability *shotScore1  )
        // calculate the prize
        // uint256 prize = 0;

        if (player1Wins) {
            winner = player1;
        } else {
            winner = player2;
        }
        delete player1;
        delete player2;

        // send the prize if the random result is even
        // if (coinFace == 0) {
        //     prize = amount * multiplier;
        //     bool sent = payable(msg.sender).send(prize); // Use send to avoid revert
        //     require(sent, "Failed to send prize");
        // }

        // emit CoinRevealed(msg.sender, requestId, coinFace, prize);
    }

    /**
     * @dev Checks if a value is non-zero.
     */
    function _isNonZero(uint256 value) internal pure returns (bool) {
        return value > 0;
    }

    /**
     * @dev Fallback function to receive FLOW.
     */
    receive() external payable {}

    fallback() external payable {}
}
