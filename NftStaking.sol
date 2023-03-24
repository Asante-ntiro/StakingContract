// SPDX-License-Identifier: MIT
pragma solidity = 0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
//import "hardhat/console.sol";


contract NftStaking {
    constructor(
        IERC20 _token,
        IERC721 _nft,
        uint256 _rewardRate,
        uint256 _startTime,
        uint256 _endTime
    ) {
        uint256 _mainStartTime = (_startTime) * 1 days;
        uint256 _mainEndTime = _mainStartTime + (_endTime * 1 days);
        token = _token;
        nft = _nft;
        rewardRate = _rewardRate;
        requiredStartTime = _mainStartTime;
        requiredEndTime = _mainEndTime;

        owner = msg.sender;
    }

    
    struct Stake {
        uint256 amount;
        uint256 startTime;
    }

    //mapping staker to their wallet
    mapping(address => Stake) public stakers;
 
    // event when user has staked NFT
    event Staked(address indexed user, uint256 amount);
    
    //event when user has unstaked NFT
    event Unstaked(address indexed user, uint256 amount);
    
    //event when user claims tokens
    event ClaimedReward(address indexed user, uint256 reward);
    
    

    function stake(uint256 _amount) external {
        uint256 mainAmount = _amount * 1e18;
        require(mainAmount > 0, "Amount must be greater than 0");
        // check if user owns our NFT
        require(nft.balanceOf(msg.sender) > 0, "You must own our NFT");
       
        token.transferFrom(msg.sender, address(this), mainAmount);
        stakes[msg.sender].amount += mainAmount;
        stakes[msg.sender].startTime = block.timestamp;

        emit Staked(msg.sender, mainAmount);
    }



    function unstake(uint256 _amount) external {
        uint256 mainAmount = _amount * 1e18;
        require(stakes[msg.sender].amount >= mainAmount, "Not enough staked");
        require(block.timestamp > (stakes[msg.sender].startTime + requiredStartTime), "staking is yet to start");
       
        stakes[msg.sender].amount -= mainAmount;
        token.transfer(msg.sender, mainAmount);

        emit Unstaked(msg.sender, mainAmount);
    }

    function calculateReward(address _user) public view returns (uint256) {
        uint256 timeStaked = block.timestamp - stakes[_user].startTime;
        uint256 reward = (stakes[_user].amount * rewardRate * timeStaked) / 1e18;
        return reward;
    }

    function claimReward() external {
        uint256 reward = calculateReward(msg.sender);
        require(reward > 0, "No reward to claim");
        require(block.timestamp > (stakes[msg.sender].startTime + requiredEndTime), "please wait for staking to complete");
       
        token.transfer(msg.sender, reward);
        token.transfer(msg.sender, stakes[msg.sender].amount);

        stakes[msg.sender].amount = 0;
        stakes[msg.sender].startTime = block.timestamp;

        emit ClaimedReward(msg.sender, reward);
    }

    function setRewardRate(uint256 _rewardRate) public onlyOwner {
        rewardRate = _rewardRate;
    }

    function setTime(uint256 _startTime, uint256 _endTime) public onlyOwner {

     uint256 _mainStartTime = (_startTime) * 1 days;
     uint256 _mainEndTime = _mainStartTime + (_endTime * 1 days);
       
        requiredStartTime = _mainStartTime;
        requiredEndTime = _mainEndTime;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can access this!");
        _;
    }
}