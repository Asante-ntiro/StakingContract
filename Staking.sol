// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;

import "hardhat/console.sol";
import "./ExampleExternalContract.sol";

/**
 * @title Staker
 * @dev A contract that allows users to stake Ether and trigger an external contract's function once a threshold is reached.
 */
contract Staker {

  // Reference to an external contract to be triggered
  ExampleExternalContract public exampleExternalContract;

  // Mapping to track individual balances of stakers
  mapping (address => uint256) balances;

  // Threshold amount required to trigger the external contract
  uint256 public constant threshold = 1 ether;

  // Event to be emitted when a user stakes Ether
  event Stake(address sender, uint amount);

  // Deadline after which the execute function can be called
  uint256 public deadline = block.timestamp + 72 hours;

  // Flag to track whether the execution is completed
  bool public isExecutionCompleted;

  // Modifier to enforce that the execution has not been completed
  modifier notCompleted() {
      require(!isExecutionCompleted, "Example Contract is already executed!");
      _;
  }

  
  /**
   * @dev Constructor that sets the address of the external contract
   * @param exampleExternalContractAddress The address of the external contract
   */
  constructor(address exampleExternalContractAddress) {
      exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
  }

  /**
   * @dev Function to stake Ether and update the sender's balance
   * Emits a Stake event
   */
  function stake() public payable {
    // Increase the sender's balance by the staked amount
    balances[msg.sender] += msg.value;
    // Emit the Stake event
    emit Stake(msg.sender, balances[msg.sender]);    
  }

  /**
   * @dev Function to execute the external contract's function if the deadline has passed and the threshold is met
   */
  function execute() public notCompleted{
    // Check if the deadline has passed and the threshold is met
    require(block.timestamp > deadline, "Deadline has not passed");
    require(address(this).balance >= threshold, "Threshold not met");

    // Set the execution flag to true
    isExecutionCompleted = true;

    // Call the external contract's complete function, forwarding the contract's balance
    exampleExternalContract.complete{value: address(this).balance}();

  }
  /**
   * @dev Function to withdraw user's balance if the threshold was not met and the deadline has passed
   */
  function withdraw() public notCompleted{
    // Get the user's balance    
    uint256 userBalance = balances[msg.sender];

    // Check if the deadline has passed
    require(timeLeft() == 0, "Deadline has not expired yet");

    // Check if the user has a balance to withdraw
    require(userBalance > 0, "No balance to withdraw");

    // Set the user's balance to 0
    balances[msg.sender] = 0;

    // Transfer the user's balance back to their address
    (bool sent,) = msg.sender.call{value: userBalance}("");
    require(sent, "Failed to send user balance back");
  }

  /**
   * @dev View function to calculate the time left before the deadline
   * @return The time left before the deadline in seconds
   */
  function timeLeft() public view returns (uint256) {
    return deadline >= block.timestamp ? deadline - block.timestamp : 0;
  }

  /**
   * @dev Special function to receive Ether and call the stake function
   */
  function receive() public {
    stake();
  }

}
