pragma solidity ^0.5.0;

import "./catkatTokenMintable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/Crowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/CappedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/crowdsale/distribution/RefundablePostDeliveryCrowdsale.sol";

// Inherit the Open Zeppeling contract standards

contract CatkatTokenSale is Crowdsale, MintedCrowdsale, CappedCrowdsale, TimedCrowdsale, RefundablePostDeliveryCrowdsale {
    
    constructor(
        uint rate, // rate in TKNbits
        uint goal, // This is the crowdsale goal
       // uint cap, // Maximum cap sales
        uint openTime,
        uint closeTime,
        address payable recipientAddress, // sale beneficiary
        
        CatkatToken token) // This is the CatkatToken itself that the CatkatTokenSale will work with 
        
        CappedCrowdsale(goal) // This is to cap the sale following CappedCrowdsale.sol
        TimedCrowdsale(openTime,closeTime) // this is to operate the sale from TimedCrowdsale.sol
        Crowdsale(rate, recipientAddress, token)
        RefundableCrowdsale(goal) 
        public {
            //constructor stay empty
        }
}

contract CatkatTokenSaleDeployer {
    address public CatkatsaleAddress;
    address public tokenAddress;
    
    constructor(
        string memory name,
        string memory symbol,
        address payable recipientAddress, // this is the address that will receive the proceeds raised by the sale
        uint goal
        //uint cap
        )
        public {
            // creates the CatkatToken and keeps the address handy
            CatkatToken token = new CatkatToken(name, symbol, 0);
            tokenAddress = address(token);
            
            // create the CatkatTokenSale and setup goals, open and close times and collecting address
            CatkatTokenSale Catkat_sale = new CatkatTokenSale(
                1, // rate is 1 token per ETH
                goal, // setup crowdsale goal
                //cap, setup maximum coin per transaction
                now, // open time is now
                now + 5 minutes, //close time is 5 minutes to test
                recipientAddress,
                token);
            CatkatsaleAddress = address(Catkat_sale);
            
            // make the CatkatTokenSale contract a minter and then make the CatkatTokenSaleDeployer renouncig its minter role 
            token.addMinter(CatkatsaleAddress);
            token.renounceMinter();
            
        }
    
}