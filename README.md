# FundMe

This is a crowdfunding smart contract that allows individuals to send funds to a central contract, and for the owner of the contract to withdraw those funds. It uses the Chainlink Price feed contract to get current ETH/USD convertsion rate. [PriceConverter.sol](./contracts/libs/PriceConverter.sol) converts the value of the funds to USD, and requires that the funds sent are at least $50.

## Using the contract

- To fund the contract, call the fund() function and send Ether along with the transaction.
- To check the total funds raised and the list of funders, you can call the funders and fundersToFunds public variables respectively.
- Only the contract owner can withdraw the funds. They can do so by calling the withdraw() function.
- Note that the contract uses a hard-coded address of a price feed contract to convert the value of the funds sent in wei to USD. Make sure that this address is correct and that the price feed contract is deployed and working correctly.

## Built With

- Solidity - Smart contract programming language

## Acknowledgments

This project was developed as part of the "Learn Blockchain, Solidity, and Full Stack Web3 Development with JavaScript – 32-Hour Course" course by [Patrick Collins](https://github.com/PatrickAlphaC)
