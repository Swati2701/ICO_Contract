//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "./MyToken.sol";
import "./CrowdSale.sol";

contract Task is Ownable{
    
    uint256 totalSupply;
    uint256 saleQuantity;
    address payable addr;
    uint256 tokensValue; //Convert ether into token 
       
    enum ICOStage { PreSale, secondSale, remainingSale}
  
    ICOStage public stage = ICOStage.PreSale;

    function TotalSupply(uint256 _totalSupply) public{
          totalSupply = _totalSupply;
      }

   

    function setICOStage(uint _stage) public onlyOwner{
     if(uint(ICOStage.PreSale) == _stage) {
         stage = ICOStage.PreSale;
         } else if (uint(ICOStage.secondSale) == _stage) {
             stage = ICOStage.secondSale;
            } else if(uint(ICOStage.remainingSale) == _stage){
                stage = ICOStage.remainingSale;
            }
    }
    function buy() public payable{
         if(stage == ICOStage.PreSale) { 
         saleQuantity = 30000000; 
         while(saleQuantity!=0){
             tokensValue = (msg.value) * 1e5 / 1 ether;
             saleQuantity -= tokensValue;
             addr.transfer(saleQuantity);
         }
       } else if (stage == ICOStage.secondSale) {
           
           saleQuantity = 50000000; 
           while(saleQuantity!=0){
             tokensValue = (msg.value) * 1e5 / 1 ether;
             saleQuantity -= tokensValue;
             addr.transfer(saleQuantity);
             }
        } else if(stage == ICOStage.remainingSale){
            saleQuantity = 20000000;
            while(saleQuantity!=0){
                tokensValue = (msg.value) * 1e5 / 1 ether;
                saleQuantity -= tokensValue;
                addr.transfer(saleQuantity);
             }
           }
    }   
}
    /*function buy() public payable{ 
        
        if(stage == ICOStage.remainingSale){
            addr.transfer(tokensValue);
        }
    }*/

   /* function forwardFunds() internal {
      if (stage == ICOStage.PreSale && saleQuantity !=0) {
          addr.transfer(tokensValue);
      } else if (stage == ICOStage.secondSale) {
          //super.forwardFunds();
      }
  }


    function _preValidatePurchase(address _beneficiary, uint256 _weiAmount) internal{}*/