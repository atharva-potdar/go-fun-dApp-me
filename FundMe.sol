// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.8.30 <0.9.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {

    // The below was all taken from Chainlink Data Feeds docs
    AggregatorV3Interface internal dataFeed;
    /**
     * Network: Sepolia
     * Aggregator: ETH/USD
     * Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
     */
    constructor() {
        dataFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
    }
    function getLatestSepoliaETHToUSDRate() public view returns (int) {
        (
            /* uint80 roundId */,
            int256 answer,
            /*uint256 startedAt*/,
            /*uint256 updatedAt*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return answer;
    }
    // Chainlink VRF can be used to get PROVABLY random numbers, since blockchains are deterministic they can't produce randomness
    // Chainlink Automation - event listeners!! :D
    // Chainlink Functions - any API call in decentralized context - end-to-end reliability

    uint8 minimumINR = 15;

    function fund() public payable {
        // We want to allow people to send money to this contract - payable keyword

        // how to convert ETH to INR/INR to ETH? Use the Chainlink oracle

        require(msg.value >= minimumINR, "min. 1 ETH required"); 
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

    function withdraw() public {}
}
