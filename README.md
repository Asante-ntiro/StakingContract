# Staker Smart Contract

This repository contains a Solidity smart contract called `Staker`. The `Staker` contract allows users to stake Ether and trigger an external contract's function once a specified threshold is reached. The contract also includes a deadline, after which users can withdraw their stake if the threshold has not been met.

## Features

- Stake Ether and track individual balances
- Set a threshold and deadline for triggering the external contract
- Execute the external contract's function if the deadline has passed and the threshold is met
- Withdraw the user's balance if the deadline has passed and the threshold has not been met
- Calculate the time left before the deadline

## Usage

1. Deploy the `ExampleExternalContract` and note its address.
2. Deploy the `Staker` contract, passing the address of the `ExampleExternalContract` as a constructor argument.
3. Users can stake Ether by calling the `stake()` function or sending Ether directly to the contract.
4. After the deadline has passed, if the threshold is met, anyone can call the `execute()` function to trigger the external contract's function.
5. If the deadline has passed and the threshold has not been met, users can call the `withdraw()` function to retrieve their staked Ether.

## Example

```solidity
// Deploy the ExampleExternalContract
ExampleExternalContract exampleExternalContract = new ExampleExternalContract();

// Deploy the Staker contract with the address of the ExampleExternalContract
Staker staker = new Staker(address(exampleExternalContract));

// Stake Ether
staker.stake{value: 1 ether}();

// Execute the external contract's function after the deadline and if the threshold is met
staker.execute();

// Withdraw Ether if the deadline has passed and the threshold has not been met
staker.withdraw();
