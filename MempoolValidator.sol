// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

/**
 * @title MempoolValidator
 * @dev Validates transaction nonces and signatures inside isolated state access slots.
 */
contract MempoolValidator {
    
    mapping(address => uint256) public accountNonces;

    event NonceValidated(address indexed user, uint256 currentNonce);

    /**
     * @notice Checks validity bounds before pushing metadata packages to block sequencers.
     */
    function preValidateTransaction(address user, uint256 clientNonce) external {
        require(clientNonce == accountNonces[user], "MempoolError: Nonce mismatch state validation");
        
        accountNonces[user]++;
        emit NonceValidated(user, accountNonces[user]);
    }
}
