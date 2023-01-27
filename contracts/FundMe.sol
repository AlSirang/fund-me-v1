// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./libs/PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    address private _priceFeedContract;
    address public owner;
    uint256 public minimumFunds = 50 * 1e18; // convert USD in terms of Wei

    address[] public funders;
    mapping(address => uint256) public fundersToFunds;

    // modifiers

    modifier onlyOwner() {
        require(msg.sender == owner, "Caller is not owner");
        _;
    }

    function fund() external payable {
        require(
            msg.value.getConversionRate(_priceFeedContract) >= minimumFunds,
            "did't send enough funds"
        );

        // if funder already exists in funders list do not add address again
        if (fundersToFunds[msg.sender] == 0) funders.push(msg.sender);
        fundersToFunds[msg.sender] += msg.value;
    }

    function withdraw() external onlyOwner {
        for (uint256 i = 0; i < funders.length; i++) {
            address funder = funders[i];
            delete fundersToFunds[funder]; // reset mapping for givein address by deleting it. it will reset value to zero
            // or
            fundersToFunds[funder] = 0; // reset value to 0
        }

        funders = new address[](0); // new empty array

        //  funds transfer

        /*
            // transfer
            // throws error if transfer failed
            payable(msg.sender).transfer(address(this).balance);

            // send
            // returns boolean for send status. true for success false for failure
            bool success = payable(msg.sender).send(address(this).balance);
            require(success, "transfer failed");
        */

        // call
        // it can be used to call any function without abi. it returns two values. function call stauts (true | false) and data (any data returned from called function)

        // (bool callSuccess, bytes memory dataReturned) = payable(msg.sender).call{value: address(this).balance}("");

        // call is recommended way to send funds
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");

        require(callSuccess, "transfer failed");
    }

    constructor(address priceFeedContract_) {
        // 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e goerli ETH/USD
        _priceFeedContract = priceFeedContract_;
        owner = msg.sender;
    }
}
