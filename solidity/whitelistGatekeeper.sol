pragma solidity ^0.8.0;

interface IERC20 {
    function transferFrom(address from, address to, uint256 value) external returns (bool);
}

contract Whitelist {
    mapping(address => bool) public isWhitelisted;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    function addToWhitelist(address tokenAddress) external onlyOwner {
        isWhitelisted[tokenAddress] = true;
    }

    function removeFromWhitelist(address tokenAddress) external onlyOwner {
        isWhitelisted[tokenAddress] = false;
    }
}

contract MainContract {
    Whitelist public whitelistContract;

    constructor(address _whitelistAddress) {
        whitelistContract = Whitelist(_whitelistAddress);
    }

    function acceptTokens(address tokenAddress, uint256 amount) external {
        require(whitelistContract.isWhitelisted(tokenAddress), "Token not whitelisted");
        
        IERC20(tokenAddress).transferFrom(msg.sender, address(this), amount);
        // Now you can process the tokens as needed
    }
}