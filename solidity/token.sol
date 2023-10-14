// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NameOfTheContract is ERC20{
    constructor() ERC20("Name_of_the_token", "Symbol_of_the_token"){
         _mint(msg.sender,XXXX*XX**XX);
    }
}

// Basic syntax
contract DigitalAssetsT is ERC20, Ownable{
    constructor() ERC20("DigitalAssetsToken", "DAT"){
         _mint(msg.sender,XXXX*XX**XX);
    }
}

// Token supply
contract DigitalAssetsT is ERC20, Ownable{
    constructor() ERC20("DigitalAssetsToken", "DAT"){
         _mint(msg.sender,10000*10**18);
    }
}

// Uncapped lazy supply
contract DigitalAssetsT is ERC20, Ownable{
    constructor() ERC20("DigitalAssetsToken", "DAT") {}

          function issueToken(address receiver, uint256 amount) public{
             _mint(msg.sender,10000*10**18);
    }
}

// Capped lazy supply
contract DigitalAssetsT is ERC20Capped, Ownable{
    constructor(uint256 cap) ERC20("DigitalAssetsToken", "DAT") ERC20Capped(cap){
}

    function issueToken() public{
        _mint(msg.sender, 10000*10**18);
    }
}

// Access control
contract DigitalAssetsT is ERC20, Ownable{
    constructor() ERC20("DigitalAssetsToken", "DAT"){}

    function issueToken() public onlyOwner{
        _mint(msg.sender, 10000*10**18);
    }
}