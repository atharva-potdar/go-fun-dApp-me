// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity >=0.8.24 <0.9.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter 
{
    /**
     * Network: ZKSync
     * Aggregator: ETH/USD
     * Address: 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF
     */
    function getLatestSepoliaETHToUSDRate() internal view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF
        );
        (
            /* uint80 roundId */,
            int256 answer,
            /*uint256 startedAt*/,
            /*uint256 updatedAt*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return uint256(answer * 1e10);
    }
    // Chainlink VRF can be used to get PROVABLY random numbers, since blockchains are deterministic they can't produce randomness
    // Chainlink Automation - event listeners!! :D
    // Chainlink Functions - any API call in decentralized context - end-to-end reliability

    function getConversionRate(uint256 ethValue) internal view returns(uint256) {
        return (ethValue * getLatestSepoliaETHToUSDRate()) / 1e18;
    }


}
