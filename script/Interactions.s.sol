// SPDX-License-Identifier: MIT

//reproducable way of writing interactions

pragma solidity ^0.8.18 ;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundingFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function fundFundMe(address mostRecentlyDeployed)  public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).fund{value : SEND_VALUE}();
        vm.stopBroadcast();
    }
    
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe" , block.chainid);
        fundFundMe(mostRecentlyDeployed);
    }
}

contract WithDrawFundMe is Script {
    uint256 constant SEND_VALUE = 0.01 ether;

    function withDrawFundMe(address mostRecentlyDeployed)  public {
        vm.startBroadcast();
        FundMe(payable(mostRecentlyDeployed)).withdraw();
        vm.stopBroadcast();
    }
    
    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("FundMe" , block.chainid);
        withDrawFundMe(mostRecentlyDeployed);
    }
    
}