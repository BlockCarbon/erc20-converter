// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenLocker is Ownable {
    // Address of the ERC-20 token to be locked
    address public tokenAddress;
    // Event to log token lock
    event TokensLocked(address indexed from, uint256 amount);

    constructor(address _tokenAddress) {
        require(_tokenAddress != address(0), "Token address cannot be zero");
        tokenAddress = _tokenAddress;
    }

    // Function to lock a specified amount of tokens indefinitely
    function lockTokens(uint256 amount) external onlyOwner {
        IERC20 token = IERC20(tokenAddress);

        // Transfer the tokens to the contract
        token.transferFrom(msg.sender, address(this), amount);

        // Log the token lock event
        emit TokensLocked(msg.sender, amount);
    }

    // Function to change the address of the ERC-20 token (onlyOwner)
    function changeTokenAddress(address newTokenAddress) external onlyOwner {
        require(newTokenAddress != address(0), "Token address cannot be zero");
        tokenAddress = newTokenAddress;
    }
}