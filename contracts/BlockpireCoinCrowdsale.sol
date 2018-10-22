pragma solidity ^0.4.24;

import "./BlockpireCoin.sol";
import "../node_modules/openzeppelin-solidity/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "../node_modules/openzeppelin-solidity/contracts/crowdsale/validation/TimedCrowdsale.sol";

// Example crowdsale
// This might be better deployed manually

contract BlockpireCoinCrowdsale is TimedCrowdsale, MintedCrowdsale {
  function BlockpireCoinCrowdsale
    (
        uint256 _openingTime,
        uint256 _closingTime,
        uint256 _rate,
        address _wallet,
        MintableToken _token
    )
    public
    Crowdsale(_rate, _wallet, _token)
    TimedCrowdsale(_openingTime, _closingTime) {

    }
}
