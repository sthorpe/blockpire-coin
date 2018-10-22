## Blockpire Coin
An `ERC20` standard token. Built on the [OpenZeppelin](https://openzeppelin.org/) framework.

## Development

### Setup

You'll need the [npm tool installed](https://www.npmjs.com/get-npm).

Download truffle https://truffleframework.com/ganache

### To deploy blockpire-coin on test or mainnet
```
$ cd blockpire-coin
$ npm install
$ truffle compile
$ truffle migrate
$ truffle console


// The account that will buy DAP tokens.
> purchaser = web3.eth.accounts[2]
'0xddac5d057c79facd674bc95dfd9104076fd34d6b'

// The address of the BPI token instance that was created when the crowdsale contract was deployed
// assign the result of BlockpireCoinCrowdsale.deployed() to the variable crowdsale
> BlockpireCoinCrowdsale.deployed().then(inst => { crowdsale = inst })
> undefined
> crowdsale.token().then(addr => { tokenAddress = addr } )
> tokenAddress
'0x87a784686ef69304ac0cb1fcb845e03c82f4ce16'
> blockpireCoinInstance = BlockpireCoin.at(tokenAddress)
// change token ownership to crowdsale so it is able to mint tokens during crowdsale
> blockpireCoinInstance.transferOwnership(crowdsale.address)

// Now check the number of BPI tokens purchaser has. It should have 0
blockpireCoinInstance.balanceOf(purchaser).then(balance => balance.toString(10))
'0'

// Buying BPI tokens
> BlockpireCoinCrowdsale.deployed().then(inst => inst.sendTransaction({ from: purchaser, value: web3.toWei(5, "ether")}))
{ tx: '0x68aa48e1f0d0248835378caa1e5b2051be35a5ff1ded82878683e6072c0a0cfc',
  receipt:
   { transactionHash: '0x68aa48e1f0d0248835378caa1e5b2051be35a5ff1ded82878683e6072c0a0cfc',
     transactionIndex: 0,
     blockHash: '0xb48ceed99cf6ddd4f081a99474113c4c16ecf61f76625a6559f1686698ee7d57',
     blockNumber: 5,
     gasUsed: 68738,
     cumulativeGasUsed: 68738,
     contractAddress: null,
     logs: [] },
  logs: [] }
undefined

// Check the amount of DAP tokens for purchaser again. It should have some now.
> blockpireCoinInstance.balanceOf(purchaser).then(balance => purchaserBlockpireCoinBalance = balance.toString(10))
'5000000000000000000000'

// When we created our token we made it with 18 decimals, which the same as what ether has. That's a lot of zeros, let's display without the decimals:
> web3.fromWei(purchaserBlockpireCoinBalance, "ether")
'5000'

```
