// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IWhitelistGatekeeper {
    function isTokenIDWhitelisted(uint256 tokenID) external view returns (bool);
}

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
}

interface IERCBurn {
    function burnTokens(address user, uint256 tokenID, uint256 amount) external;
}

contract TokenVerificationHelper {
    
    address public whitelistGatekeeperAddress;
    address public ercBurnAddress;

    constructor(address _whitelistGatekeeperAddress, address _ercBurnAddress) {
        whitelistGatekeeperAddress = _whitelistGatekeeperAddress;
        ercBurnAddress = _ercBurnAddress;
    }

    /**
     * @param user The user's wallet address.
     * @param tokenID The ERC-20 token ID.
     * @param amount The token amount.
     * @return success Whether the operation was successful.
     */
    function verifyAndBurn(address user, uint256 tokenID, uint256 amount) external returns (bool success) {
        IWhitelistGatekeeper gatekeeper = IWhitelistGatekeeper(whitelistGatekeeperAddress);
        
        // Verify if token ID is whitelisted
        require(gatekeeper.isTokenIDWhitelisted(tokenID), "Token ID not whitelisted");

        IERC20 token = IERC20(tokenID);
        
        // Check if user has the required token balance
        require(token.balanceOf(user) >= amount, "Insufficient token balance");

        // Transfer the tokens to this contract
        require(token.transferFrom(user, address(this), amount), "Token transfer failed");

        // Approve the tokens to be burnt by the ercBurn contract
        require(token.approve(ercBurnAddress, amount), "Token approval failed");

        // Burn the tokens
        IERCBurn(ercBurnAddress).burnTokens(user, tokenID, amount);
        
        return true;
    }
}
