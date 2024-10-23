# Basketball Game with Random Coin Toss Contracts - Foundry Integration

This repository contains an adaptation of a random coin toss smart contract system, now extended to simulate basketball games with players. The contract includes logic for randomizing outcomes, managing players, and simulating basketball game events. The core testing suite, including unit tests for the new `Player` entity, can be found in the `Player.t.sol` test file.

Contracts adapted from: https://github.com/onflow/random-coin-toss

## Project Structure

```bash
.
├── src
|   ├── mocks
|   |   ├── MockCadenceRandomConsumer.sol # Used to create tests
|   ├── CadenceArchUtils.sol # Util library for calling randomness
|   ├── CadenceArchRandomConsumer.sol # Helper contract for randomness
|   ├── PlayerNFT.sol #NFT to represent each player and their score
|   ├── ShootOff.sol # The actual shoot off game
│   ├── Xorshift128plus.sol.sol    # Util library for bit shifting
│   ├── Player.sol            # Player entity that can participate in basketball games
├── test
|   ├── CadenceRandomConsumer.t.sol #Tests for the random consumer
│   ├── CoinToss.t.sol        # Tests for random coin toss logic
│   ├── Player.t.sol          # Tests for the Player entity and
basketball game logic
├── foundry.toml              # Foundry configuration file
├── script
│   ├── Deploy.s.sol          # Deployment script for Shootoff
└── README.md                 # This file
```

## Prerequisites

Before you begin, ensure you have met the following requirements:

- [Foundry](https://github.com/foundry-rs/foundry) installed for compiling, testing, and deploying smart contracts.
- A compatible Solidity compiler version (check `foundry.toml` for the exact version).

## Installation

1. **Clone the repository**:

   ```bash
   git clone https://github.com/yourusername/basketball-game-foundry.git
   cd basketball-game-foundry
   ```

2. **Install dependencies** (if any):

   ```bash
   forge install
   ```

3. **Compile the contracts**:

   ```bash
   forge build
   ```

## Running Tests

The repository includes test files written for Foundry. The new tests for the `Player` and basketball game logic are in `Player.t.sol`.

To run all tests:

```bash
forge test
```

To run specific tests for the `Player`:

```bash
forge test --match-path test/Player.t.sol
```

## Contracts

### `ShootOff.sol`
An modification of the coin toss logic that incorporates basketball game-specific rules. It allows two players to compete in a simulated basketball game where each player stakes a basketball player with a set shooting probability. Then a random number is used to determine a winner between the battle. 

### `NFTPlayer.sol`
The `NFTPlayer` contract defines a player entity that can participate in basketball games. Players have a shooting probability attribute which is used when they participate.

## Testing Overview
_Wile there are other tests we will focus on Player.t.sol_

- **`Player.t.sol`**: The core test file for the player-based basketball game. It includes unit tests for player actions, game results, and integration with the randomization provided by the `CoinToss` contract. It also features a fuzz test as a demonstration.

## Deployment

To deploy the contracts to a network, you can use the deployment script provided under `script/Deploy.s.sol`. Make sure your deployment script is configured properly with network and contract addresses if necessary.

Run the deployment:

```bash
forge script script/Deploy.s.sol --rpc-url <your_rpc_url>
```

## Contribution

If you’d like to contribute to this project, please fork the repository and use a feature branch. Pull requests are warmly welcome.

## License

This project is licensed under the MIT License - see the `LICENSE` file for details.

---

This README should give users and developers enough context to get started with your project, including installation, testing, and contributing.
