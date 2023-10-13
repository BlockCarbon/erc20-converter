// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenBurner is Ownable {
    // Address of the ERC-20 token to be burned
    address public tokenAddress;
    // Event to log token burn
    event TokensBurned(address indexed from, uint256 amount);

    constructor(address _tokenAddress) {
        require(_tokenAddress != address(0), "Token address cannot be zero");
        tokenAddress = _tokenAddress;
    }

    // Function to burn a specified amount of tokens
    function burnTokens(uint256 amount) external onlyOwner {
        IERC20 token = IERC20(tokenAddress);
        uint256 balanceBefore = token.balanceOf(address(this));

        // Ensure that the contract has enough tokens to burn
        require(balanceBefore >= amount, "Insufficient balance to burn");

        // Transfer the tokens to the contract and burn them
        token.transferFrom(msg.sender, address(this), amount);
        token.transfer(address(0), amount); // Send tokens to the zero address (burn)

        uint256 balanceAfter = token.balanceOf(address(this));
        require(balanceAfter == balanceBefore - amount, "Burn failed");

        // Log the token burn event
        emit TokensBurned(msg.sender, amount);
    }

    // Function to change the address of the ERC-20 token (onlyOwner)
    function changeTokenAddress(address newTokenAddress) external onlyOwner {
        require(newTokenAddress != address(0), "Token address cannot be zero");
        tokenAddress = newTokenAddress;
    }
}