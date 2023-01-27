// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice(address _priceFeedContract)
        internal
        view
        returns (uint256)
    {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            _priceFeedContract
        );
        // ETH/USD price feed contract

        (, int256 answer, , , ) = priceFeed.latestRoundData();

        // price has 8 decimals and to make it compatible with eth units it should be in Wei
        return uint256(answer * 1e10); // convert USD price into Wei.
    }

    function getConversionRate(uint256 ethAmount, address _priceFeedContract)
        internal
        view
        returns (uint256)
    {
        uint256 ethPrice = getPrice(_priceFeedContract); // get latest price of ETH/USD
        return (ethAmount * ethPrice) / 1e18; // compute ethAmount in terms of USD -> fix decimals
    }
}
