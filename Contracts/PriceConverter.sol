// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
      function getPriceOfEth () public view returns(uint256) {
       AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();

        return uint256(price * 1e10);
    }

    function getConversion (uint256 ethAmount) public view returns(uint256) {
        uint256 ethPrice = getPriceOfEth();
        uint256 ethAmountInUSD = (ethAmount * ethPrice) / 1e18;
        return  ethAmountInUSD;
    }
}