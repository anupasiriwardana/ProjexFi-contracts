// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract RevenueRouter {
    // 1. State Variables
    address payable public creatorAddress;
    uint256 public totalDividendPool;

    // 2. The Event (Your Node.js backend will listen for this!)
    event PaymentReceived(address indexed customer, uint256 amountPaid, uint256 creatorCut, uint256 investorCut);

    // 3. Constructor (Runs once when deployed)
    constructor(address payable _creatorAddress) {
        creatorAddress = _creatorAddress;
    }

    // 4. The Core Logic: Intercepting and Splitting the Money
    function routePayment() public payable {
        // Require that the customer actually sent some money
        require(msg.value > 0, "You must send ETH/USDC to pay.");

        uint256 paymentAmount = msg.value;

        // --- THE WEB3 MATH LESSON ---
        // Solidity does NOT support decimals (floating points). You cannot do `amount * 0.80`.
        // Instead, you must multiply first, then divide. 
        
        // Calculate the 80% cut for the creator
        uint256 creatorCut = (paymentAmount * 80) / 100;
        
        // Calculate the 20% cut for the investors
        uint256 investorCut = paymentAmount - creatorCut; // Subtraction prevents rounding dust

        // Add the 20% to the internal dividend pool ledger
        totalDividendPool += investorCut;

        // Instantly push the 80% to the Creator's wallet
        (bool success, ) = creatorAddress.call{value: creatorCut}("");
        require(success, "Transfer to creator failed!");

        // Broadcast the event to the blockchain so your Node.js server hears it
        emit PaymentReceived(msg.sender, paymentAmount, creatorCut, investorCut);
    }
}
