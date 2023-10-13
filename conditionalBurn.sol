// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import Chainlink's AggregatorV3Interface
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// Reference to the token contract that has the burning functionality
interface ITokenContract {
    function burn(uint256 amount) external;
    // Other functions like balanceOf, etc.
}

contract CarbonCreditMonitor {
    // Chainlink AggregatorV3Interface reference
    AggregatorV3Interface internal priceFeed;
    
    // Token contract reference
    ITokenContract public tokenContract;
    
    // Owner of the contract (usually for administrative functions)
    address public owner;
    
    // Threshold value
    int256 public thresholdPrice;
    
    constructor(address _priceFeed, address _tokenContract, int256 _thresholdPrice) {
        priceFeed = AggregatorV3Interface(_priceFeed);
        tokenContract = ITokenContract(_tokenContract);
        thresholdPrice = _thresholdPrice;
        owner = msg.sender;
    }
    
    function setThresholdPrice(int256 _newThreshold) external {
        require(msg.sender == owner, "Only owner can set threshold");
        thresholdPrice = _newThreshold;
    }
    
    function checkPriceAndBurn() external {
        int256 currentPrice = getCurrentPrice();
        
        if(currentPrice < thresholdPrice) {
            uint256 balance = ITokenContract(tokenContract).balanceOf(address(this));
            ITokenContract(tokenContract).burn(balance);
        }
    }
    
    function getCurrentPrice() public view returns (int256) {
        (
            , 
            int256 price, 
            , 
            , 
        ) = priceFeed.latestRoundData();
        return price;
    }
}