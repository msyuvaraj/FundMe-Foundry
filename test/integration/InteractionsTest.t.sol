pragma solidity ^0.8.18;

import {Test , console} from "forge-std/Test.sol" ;
import {FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {FundingFundMe, WithDrawFundMe} from "../../script/Interactions.s.sol";

contract InteractionsTest is Test {
    address USER = makeAddr("user");
    FundMe fundMe;
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER , STARTING_BALANCE);    
    }

    function testUserCanFundInteractions() public {
        FundingFundMe fundingFundMe = new FundingFundMe();
        
        fundingFundMe.fundFundMe(address(fundMe));
        address funder = fundMe.getFunder(0);
        console.log(funder);
        //console.log(address(fundMe));
        console.log(fundMe.getOwner());

        WithDrawFundMe withDrawFundMe = new WithDrawFundMe();
        withDrawFundMe.withDrawFundMe(address(fundMe));
        
        assert(address(fundMe).balance == 0);
        
    }
}