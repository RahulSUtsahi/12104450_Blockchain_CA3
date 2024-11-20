// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@openzeppelin/contracts/access/AccessControl.sol";

contract CA3 is AccessControl{
    error isNotTheOwner(address caller);
    error balanceTooLow(uint256 currentBal, uint256 requestedBal);
   
    constructor(address _owner) payable{
        _grantRole(DEFAULT_ADMIN_ROLE, _owner);
    }

// Withdraw funds from the contract
    function withdraw(address payable to, uint256 amount) external onlyRole(DEFAULT_ADMIN_ROLE){
        uint256 balance = address(this).balance;
        if (balance < amount) revert balanceTooLow(balance, amount);
        to.transfer(amount);
    }
   // Receive Ether
    receive() external payable {}
}