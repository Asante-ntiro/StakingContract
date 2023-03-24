# StakingContract
This is an NFT Staking Smart Contract
#NFT Staking Smart Contract
This smart contract allows users to stake an ERC20 token in exchange for rewards, which are calculated based on the amount of time they have staked and the reward rate set by the contract owner. Users can also stake their NFT to participate in the staking process. Once the staking period is over, users can claim their rewards and unstake their tokens.

##Requirements
Solidity compiler version 0.8.0
OpenZeppelin ERC721 and ERC20 contracts
##Usage
Deploy the contract, passing in the following parameters:

_token: the address of the ERC20 token contract to be staked
_nft: the address of the ERC721 NFT contract to be staked
_rewardRate: the reward rate (in wei per second) set by the contract owner
_startTime: the start time of the staking period (in days from contract deployment)
_endTime: the end time of the staking period (in days from contract deployment)
Users can then stake their ERC20 tokens by calling the stake function, passing in the amount of tokens they want to stake (in wei).

Users can also stake their NFT by calling the stake function after making sure they own the NFT first.

Once the staking period is over, users can claim their rewards by calling the claimReward function. The rewards will be transferred to their wallet along with the staked ERC20 tokens.

Users can also unstake their ERC20 tokens by calling the unstake function, passing in the amount of tokens they want to unstake (in wei).

##Events
The contract emits the following events:

Staked: when a user has staked tokens or NFT
Unstaked: when a user has unstaked tokens
ClaimedReward: when a user has claimed their rewards
##License
This smart contract is licensed under the MIT License.
