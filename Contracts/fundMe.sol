// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

contract fundMe {

    using  PriceConverter for uint256;

    uint256 public constant MINIMUM_USD = 5e18;

    address[] public  fundersAddress;

    mapping(address fundersAddress => uint256 amountFunded) public addressToAmountFunded;

    address public immutable i_owner;

    constructor () {
        i_owner = msg.sender; // deployer of the contract
    }

    function fund() public payable {

        require(msg.value.getConversion() >= MINIMUM_USD, "Didn't send enough ETH");
        fundersAddress.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < fundersAddress.length; funderIndex++) {
            address funder =  fundersAddress[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // // reset the array
        // fundersAddress = new address[](0);
        // // withdraw funds

        // // transfer
        // payable(msg.sender).transfer(address(this).balance);

        // // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "send failed");

        // //call it been used as a transaction
        (bool callSuccess, )= payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier  onlyOwner() {
        require(msg.sender == i_owner, "mst be the owner");
        _;
    }

  

}