// SPDX-License-Idetifier: MIT
//SPDX-License-Identifier: GPL-2.0
//SPDX-License-Identifier: GPL-2.0+
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./MyToken.sol";
import "./CrowdSale.sol";

//30000000000000000000000000
contract MyTokenSale is Crowdsale, Ownable{
    address beneficiary;
    uint256 preSaleQuantity;
    uint256 secondSaleQuantity;
    uint256 remainingSaleQuantity;
    uint256 totalSupply;
    uint256 Rate;
    IERC20 private tokens;
    using SafeMath for uint256;
    constructor (uint256 _rate, address payable _wallet, IERC20 _token) Crowdsale(_rate, _wallet, _token){
        preSaleQuantity = 30000000 ;
        secondSaleQuantity = 50000000 ;
        remainingSaleQuantity = 20000000;
    }

    enum ICOStage { PreSale, secondSale, remainingSale}
  
    ICOStage public stage = ICOStage.PreSale;

    /*function TotalSupply(uint256 _totalSupply) public{
          totalSupply = _totalSupply;
    }*/
   
   /* function setICOStage(uint _stage) public onlyOwner{
     
     if(uint(ICOStage.PreSale) == _stage) {
         stage = ICOStage.PreSale;
         //preSaleQuantity = 30000000;
         } else if (uint(ICOStage.secondSale) == _stage) {
             stage = ICOStage.secondSale;
             //secondSaleQuantity = 50000000;
            } else if(uint(ICOStage.remainingSale) == _stage){
                stage = ICOStage.remainingSale;
                //remainingSaleQuantity = 20000000;

            }
     if (stage == ICOStage.PreSale) {
        setCurrentRate(300000);
      } else if (stage == ICOStage.secondSale) {
        setCurrentRate(600000);
      } else {
          // set rate for remainingSale stage
          setCurrentRate(0);
        }
    } */
  
  function CalculateRate() public view returns (uint256) {
    if(stage == ICOStage.PreSale){
      return 300000;
    } else if( stage == ICOStage.secondSale){
      return 500000;
    } else{
      return 400000;
    }
  }

 /* function setCurrentRate(uint256 _rate) private {
      Rate = _rate;  
    }  */
  //event updateQuantity(uint256 preSaleQuantity);

  function _getTokenAmount(uint256 weiAmount) internal view override returns (uint256){
       return weiAmount.mul(CalculateRate());
       
  }

 
  function _processPurchase(address beneficiary, uint256 tokenAmount) internal override{
   if (stage == ICOStage.PreSale) {
      //setCurrentRate(300000);
      CalculateRate();
      require(preSaleQuantity - tokenAmount/10 **18 >= 0);
      preSaleQuantity -= tokenAmount/ 10 **18;
      //emit updateQuantity(preSaleQuantity);
      if(preSaleQuantity == 0){
        stage = ICOStage.secondSale;
      }
   }else if (stage ==ICOStage.secondSale) {
      //setCurrentRate(600000);
      CalculateRate();
      require(secondSaleQuantity - tokenAmount/10 **18 >= 0);
      secondSaleQuantity -= tokenAmount/10 **18;
      if(secondSaleQuantity == 0){
        stage = ICOStage.remainingSale;
      }
   }else if (stage ==ICOStage.remainingSale) {
      //setCurrentRate(400000);
      CalculateRate();
      require(remainingSaleQuantity - tokenAmount/10 **18 >= 0);
      remainingSaleQuantity -= tokenAmount/10 **18;
   }
}

}