// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.8.30 <0.9.0;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 constant MINIMUM_USD = 5e18;
    address[] public funders;
    mapping(address funder => uint256 valueFunded) public funderMoneyMap;

    address immutable i_owner;

    constructor() {
        i_owner = msg.sender;
    }

    modifier ownerOnly() {
        // require(msg.sender == i_owner, "Only owner can perform this transaction!");
        if (msg.sender != i_owner) {revert NotOwner();}
        _;
    }

    function fund() public payable {
        // We want to allow people to send money to this contract - payable keyword

        // how to convert ETH to INR/INR to ETH? Use the Chainlink oracle

        require(msg.value.getConversionRate() >= MINIMUM_USD, "not enuf ETH"); 
    	// msg.sender is the sender of this function
	    funders.push(msg.sender);
	    funderMoneyMap[msg.sender] += msg.value;
        // 10^18 Wei = 1 ETH, msg value stores the value sent into the contract

        // If a transaction fails, the actions performed by the transaction
        // i.e. any statements run are reverted. Gas is spent still though - but
        // with a key distinction. Only gas used before a failed transaction statement
        // is gone. Gas that was used to execute the rest of the function/transaction
        // is sent back to the user.

        // The following fields are present in a transaction - 
        // nonce, gas price, gas limit, to, 
        // value (the value we send), data, v,r,s(components of Tx signature)
    }

    function withdraw() public ownerOnly {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            funderMoneyMap[funders[funderIndex]] = 0;
        }
	    funders = new address[](0); // start at length 0
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "withdraw fail");
    }

    // Explainer from: https://solidity-by-example.org/fallback/
    //                  send Ether
    //                       |
    //            msg.data is empty?
    //                 /           \
    //             yes             no
    //              |                |
    //     receive() exists?     fallback()
    //         /        \
    //      yes          no
    //       |            |
    //   receive()     fallback()


    fallback() external payable {
        fund();
    }

    receive() external payable {
        fund();
    }
}
