pragma solidity ^0.4.20;

import 'zeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

contract BlockpireCoin is StandardToken {
  string public name = 'BlockpireCoin';
  string public symbol = 'BPI';
  uint8 public decimals = 2;
  uint public INITIAL_SUPPLY = 12000;

  function BlockpireCoin() public {
    totalSupply_ = INITIAL_SUPPLY;
    balances[msg.sender] = INITIAL_SUPPLY;
  }
}
