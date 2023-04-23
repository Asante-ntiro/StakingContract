# NFT Staking Contract

This is a smart contract for staking NFTs and earning ERC20 tokens as rewards.

## Features

- Stake NFTs and earn ERC20 token rewards.
- Events for staking, unstaking, and claiming rewards.
- Built with OpenZeppelin libraries for ERC721 and ERC20 token standards.

## Installation

1. Install npm dependencies:

```bash
npm install @openzeppelin/contracts

## Usage

1. Deploy the NftStaking contract with the following constructor parameters:

_token: The address of the ERC20 token contract.
_nft: The address of the ERC721 NFT contract.
_rewardRate: The reward rate per day (in ERC20 tokens).
_startTime: The start time of the staking period (in days since Unix epoch).
_endTime: The end time of the staking period (in days since Unix epoch).
Stake NFTs using the stake(uint256 _amount) function:

_amount: The number of NFTs to stake.
Unstake NFTs using the unstake(uint256 _amount) function:

_amount: The number of NFTs to unstake.
Claim earned rewards using the claimRewards() function.

Events
Staked(address indexed user, uint256 amount): Emitted when a user stakes NFTs.
Unstaked(address indexed user, uint256 amount): Emitted when a user unstakes NFTs.
ClaimedReward(address indexed user, uint256 reward): Emitted when a user claims their rewards.
Requirements
Users must own the specified NFT to stake it.
Staking and unstaking amounts must be greater than 0.
Contract Code
The contract code can be found here.

License
This project is licensed under the MIT License.