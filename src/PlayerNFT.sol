// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "lib/openzeppelin-contracts/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";

/**
 * @title PlayerNFT
 * @dev An ERC-721 contract that represents basketball players, each with a shooting probability.
 */
contract PlayerNFT is ERC721URIStorage, Ownable {
    // Counter to assign unique token IDs
    uint256 public nextTokenId;

    // Mapping from token ID to player's shooting probability (out of 100)
    mapping(uint256 => uint8) public playerShootingProbability;

    event PlayerCreated(
        uint256 indexed tokenId,
        address indexed owner,
        uint8 shootingProbability
    );

    constructor() ERC721("BasketballPlayer", "BPLR") Ownable(msg.sender) {}

    /**
     * @dev Function to mint a new Player NFT.
     * @param to Address to receive the NFT.
     * @param shootingProbability Probability of making a shot, as a percentage (1-100).
     * @param tokenURI URI containing player metadata.
     */
    function mintPlayer(
        address to,
        uint8 shootingProbability,
        string memory tokenURI
    ) external onlyOwner {
        require(
            shootingProbability > 0 && shootingProbability <= 100,
            "Invalid shooting probability"
        );

        uint256 tokenId = nextTokenId;
        _mint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
        playerShootingProbability[tokenId] = shootingProbability;
        nextTokenId++;

        emit PlayerCreated(tokenId, to, shootingProbability);
    }

    /**
     * @dev Function to update the shooting probability of an existing player.
     * @param tokenId The ID of the player NFT.
     * @param newProbability New shooting probability (1-100).
     */
    function updateShootingProbability(
        uint256 tokenId,
        uint8 newProbability
    ) external onlyOwner {
        require(_ownerOf(tokenId) != address(0), "Player does not exist");
        require(
            newProbability > 0 && newProbability <= 100,
            "Invalid shooting probability"
        );

        playerShootingProbability[tokenId] = newProbability;
    }
}
