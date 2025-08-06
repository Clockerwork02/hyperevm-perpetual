// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title HyperEVM Perpetual Contract
 * @dev Professional HYPE collection contract for HyperEVM Perpetual trading platform
 * Contract Address: 0xf96dd9f99c9bb2b40fbdc17e0ede7c3bfe50656c
 * Network: HyperEVM (Chain ID: 999)
 * Deployed: August 6, 2025
 */
contract HyperEVMPerpetual {
    address public owner;
    
    event HYPEReceived(address indexed from, uint256 amount);
    event FundsWithdrawn(address indexed owner, uint256 amount);
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
    
    constructor() {
        owner = msg.sender;
    }
    
    /**
     * @dev Receives HYPE transfers from users
     * Automatically called when users send HYPE to this contract
     */
    receive() external payable {
        require(msg.value > 0, "No funds");
        emit HYPEReceived(msg.sender, msg.value);
    }
    
    /**
     * @dev Allows owner to withdraw all accumulated HYPE
     * Only the contract owner can call this function
     */
    function withdrawAllFunds() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds");
        
        (bool success, ) = payable(owner).call{value: balance}("");
        require(success, "Transfer failed");
        
        emit FundsWithdrawn(owner, balance);
    }
    
    /**
     * @dev Allows owner to withdraw specific amount of HYPE
     * @param amount Amount of wei to withdraw
     */
    function withdrawAmount(uint256 amount) external onlyOwner {
        require(amount > 0, "Invalid amount");
        require(address(this).balance >= amount, "Insufficient funds");
        
        (bool success, ) = payable(owner).call{value: amount}("");
        require(success, "Transfer failed");
        
        emit FundsWithdrawn(owner, amount);
    }
    
    /**
     * @dev Returns the current HYPE balance of the contract
     * @return Current balance in wei
     */
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
    
    /**
     * @dev Returns contract owner address
     * @return Owner address
     */
    function getOwner() external view returns (address) {
        return owner;
    }
}