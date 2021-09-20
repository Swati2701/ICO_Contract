//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.6.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "./MyToken.sol";
import "./CrowdSale.sol";

contract task is Ownable{
    
    uint256 totalSupply;
    uint256 saleQuantity;
    address payable addr;
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
     if(stage == ICOStage.PreSale) { 
         saleQuantity = 30000000;
       } else if (stage == ICOStage.secondSale) {
           saleQuantity = 50000000;
           }
    }

    function buy() public payable{ 
        if(stage == ICOStage.remainingSale){
            addr.transfer(msg.value);
        }
    }
 /**   function _forwardFunds() internal{
        if(stage == ICOStage.PreSale) { 
         addr.transfer(msg.value);
       } else if (stage == ICOStage.secondSale) {
           //super._forwardFunds();
           }
    }
}
       function buyTokens(address _addr, uint256 _saleQuantity) public {
        _saleQuantity = saleQuantity;
        _addr.transfer(_saleQuantity);
    } 


    function _preValidatePurchase(address _beneficiary, uint256 _weiAmount) internal{}*/

}