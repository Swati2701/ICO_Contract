pragma solidity ^0.6.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "./MyToken.sol";
import "./CrowdSale.sol";


contract MyTokenSale is Crowdsale, Ownable{
    address beneficiary;
    uint256 preSaleQuantity;
    uint256 secondSaleQuantity;
    uint256 remainingSaleQuantity;
    uint256 totalSupply;
    uint256 Rate;
    IERC20 private tokens;
    constructor (uint256 _rate, address payable _wallet, IERC20 _token) Crowdsale(_rate, _wallet, _token) public{
        preSaleQuantity = 300000000;
        secondSaleQuantity = 500000000;
        remainingSaleQuantity = 200000000;
    }

    enum ICOStage { PreSale, secondSale, remainingSale}
  
    ICOStage public stage = ICOStage.PreSale;

    function TotalSupply(uint256 _totalSupply) public{
          totalSupply = _totalSupply;
    }
   
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

  function setCurrentRate(uint256 _rate) private {
      Rate = _rate;
    }


  function _getTokenAmount(uint256 weiAmount) internal view override returns (uint256){
        return weiAmount.mul(Rate);
  }

 
 function _updatePurchasingState(address beneficiary, uint256 weiAmount) internal override{
   if (stage == ICOStage.PreSale) {
      setCurrentRate(300000);
      require(preSaleQuantity - weiAmount >= 0);
      preSaleQuantity -= weiAmount;
      if(preSaleQuantity == 0){
        stage = ICOStage.secondSale;
      }
   }else if (stage ==ICOStage.secondSale) {
      setCurrentRate(600000);
      require(secondSaleQuantity - weiAmount >= 0);
      secondSaleQuantity -= weiAmount;
      if(secondSaleQuantity == 0){
        stage = ICOStage.remainingSale;
      }
   }else if (stage ==ICOStage.remainingSale) {
      setCurrentRate(0);
      require(remainingSaleQuantity - weiAmount >= 0);
      remainingSaleQuantity -= weiAmount;
   }
}

}