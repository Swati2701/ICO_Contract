//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.0;
import "@openzeppelin/contracts/access/Ownable.sol";


contract task is Ownable{
    
     uint256 saleQuantity;
     enum ICOStage { PreSale, secondSale}
  
     ICOStage public stage = ICOStage.PreSale;

     function setICOStage(uint _stage) public onlyOwner{
     if(uint(ICOStage.PreSale) == _stage) {
         stage = ICOStage.PreSale;
         } else if (uint(ICOStage.secondSale) == _stage) {
             stage = ICOStage.secondSale;
            }
     if(stage == ICOStage.PreSale) { 
         saleQuantity = 30000000;
       } else if (stage == ICOStage.secondSale) {
           saleQuantity = 50000000;
           }
        }
}
