pragma solidity ^0.6.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "./MyToken.sol";
import "./CrowdSale.sol";


contract MyTokenSale is Crowdsale, Ownable{
    address payable addr;
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

   /* function TotalSupply(uint256 _totalSupply) public{
          totalSupply = _totalSupply;
      }*/
   
    function setICOStage(uint _stage) public onlyOwner{
     
     if(uint(ICOStage.PreSale) == _stage) {
         stage = ICOStage.PreSale;
         } else if (uint(ICOStage.secondSale) == _stage) {
             stage = ICOStage.secondSale;
            } else if(uint(ICOStage.remainingSale) == _stage){
                stage = ICOStage.remainingSale;
            }
     
     if (stage == ICOStage.PreSale) {
        setCurrentRate(300000);
      } else if (stage == ICOStage.secondSale) {
        setCurrentRate(600000);
      } else {
           
           // set rate for remainingSale stage
            setCurrentRate(0);
        }
    }

    function setCurrentRate(uint256 _rate) private {
      Rate = _rate;
    }

    function calculateRate() public payable {
    uint256 weiAmount = msg.value;
    uint256 tokenValue = _getTokenAmount(weiAmount);       //msg.value.mul(Rate);


    if (stage == ICOStage.PreSale) {
        require(preSaleQuantity - tokenValue >= 0);
        //msg.sender.transfer(tokenValue);
        _forwardFunds();
        _deliverTokens(addr, tokenValue);
        preSaleQuantity -= tokenValue;
        }

     if (stage ==ICOStage.secondSale) {
        require(secondSaleQuantity - tokenValue >= 0);
        //msg.sender.transfer(tokenValue);
        _forwardFunds();
        _deliverTokens(addr, tokenValue);
        secondSaleQuantity -= tokenValue;
            return ;
        }
        if (stage ==ICOStage.remainingSale) {
            require(remainingSaleQuantity - tokenValue >= 0);
            //msg.sender.transfer(tokenValue);
            _forwardFunds();
            _deliverTokens(addr, tokenValue);
            remainingSaleQuantity -= tokenValue;
            return ;
        }

        buyTokens(msg.sender);
  }


  function _getTokenAmount(uint256 weiAmount) internal view override returns (uint256){
        return weiAmount.mul(Rate);
  }

   function forwardFunds() internal {
      if (stage == ICOStage.PreSale) {
          addr.transfer(msg.value);
      } else if (stage == ICOStage.secondSale) {
          addr.transfer(msg.value);
      } else {
          super._forwardFunds();
      }
  } 

  function _deliverTokens(address beneficiary, uint256 tokenAmount) internal override{
        tokens.safeTransfer(beneficiary, tokenAmount);
    }
}