// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenBurnerAndDataStorage is Ownable {
    // Address of the ERC-20 token to be burned
    address public tokenAddress;
    // Hashed Cardano wallet address
    bytes32 public hashedCardanoWallet;
    // Event to log token burn and data storage
    event TokensBurnedAndDataStored(address indexed from, uint256 amount, bytes32 hashedAddress);

    constructor(address _tokenAddress) {
        require(_tokenAddress != address(0), "Token address cannot be zero");
        tokenAddress = _tokenAddress;
    }

    // Function to burn a specified amount of tokens and store a hashed Cardano wallet address
    function burnTokensAndStoreData(uint256 amount, bytes32 _hashedAddress) external onlyOwner {
        IERC20 token = IERC20(tokenAddress);

        // Transfer the tokens to the contract
        token.transferFrom(msg.sender, address(this), amount);

        // Log the token burn and data storage event
        emit TokensBurnedAndDataStored(msg.sender, amount, _hashedAddress);

        // Store the hashed Cardano wallet address
        hashedCardanoWallet = _hashedAddress;
    }

    // Function to change the address of the ERC-20 token (onlyOwner)
    function changeTokenAddress(address newTokenAddress) external onlyOwner {
        require(newTokenAddress != address(0), "Token address cannot be zero");
        tokenAddress = newTokenAddress;
    }
}