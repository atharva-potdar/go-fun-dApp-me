// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.8.30 <0.9.0;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 minimumUSD = 5e18;
    address[] public funders;
    mapping(address funder => uint256 valueFunded) public funderMoneyMap;

    function fund() public payable {
        // We want to allow people to send money to this contract - payable keyword

        // how to convert ETH to INR/INR to ETH? Use the Chainlink oracle

        require(msg.value.getConversionRate() = minimumUSD, "insufficient ETH sent"); 
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

    function withdraw() public {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            funderMoneyMap[funders[funderIndex]] = 0;
        }
	funders = new address[](0); // start at length 0
    }
}
