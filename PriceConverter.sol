// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.8.30 <0.9.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library priceConverter 
{
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
    function getLatestSepoliaETHToUSDRate() internal view returns (uint256) {
        (
            /* uint80 roundId */,
            int256 answer,
            /*uint256 startedAt*/,
            /*uint256 updatedAt*/,
            /*uint80 answeredInRound*/
        ) = dataFeed.latestRoundData();
        return uint256(answer * 1e10);
    }
    // Chainlink VRF can be used to get PROVABLY random numbers, since blockchains are deterministic they can't produce randomness
    // Chainlink Automation - event listeners!! :D
    // Chainlink Functions - any API call in decentralized context - end-to-end reliability

    function getConversionRate(uint256 ethValue) internal view returns(uint256) {
        return (ethValue * getLatestSepoliaETHToUSDRate()) / 1e18;
    }


}
