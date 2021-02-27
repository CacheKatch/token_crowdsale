# token_crowdsale
![crowdsale](Images/crowdsale.gif)

This repository consists of developing a crowdsale token offering (catkatToken) expected to run for 24 weeks with the objective of raising 300 Ether.

To test the code the token objective was reduced to 20 and the run time 5 mins.



## Contract design:

The catkatToken crowdsale consists of 3 contracts distributed in 2 files:

&ensp; **Mintable file:** This file is deployed with the name `catkatTokenMintable.sol` which contains a contract `CatkatToken` designed to mint new tokens when called.

&ensp; **Crowdsale file:** This file is deployed with the name `catkatTokenCrowdsale.sol` which contains two contracts: CatkatTokenSale and the CatkatTokenSaleDeployer. 

The contract `CatkatTokenSale` is responsible for seting up the crowdsale terms: time of the crowdsale, goal of the crowdsale, crowdsale open time and crowdsale closing time.

The contract `CatkatTokenSaleDeployer` is responsible for launching the sale and the token minting contract for the crowdsale event. After the launching the contract renounces to its minting role.

## Inheritances:



