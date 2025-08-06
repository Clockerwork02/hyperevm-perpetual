// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract HyperliquidPump is Ownable, ReentrancyGuard, Pausable {
    
    struct Trade {
        address user;
        string tokenSymbol;
        uint256 amount;
        bool isBuy;
        uint256 timestamp;
        uint256 leverage;
    }
    
    mapping(address => uint256) public userDeposits;
    mapping(address => Trade[]) public userTrades;
    mapping(address => bool) public authorizedRecovery;
    
    Trade[] public allTrades;
    uint256 public totalDeposits;
    
    event TradeExecuted(
        address indexed user,
        string tokenSymbol,
        uint256 amount,
        bool isBuy,
        uint256 leverage,
        uint256 timestamp
    );
    
    event FundsDeposited(address indexed user, uint256 amount);
    event FundsRecovered(address indexed user, uint256 amount, address recoveredBy);
    
    constructor() {
        // Owner can recover funds for users
        authorizedRecovery[msg.sender] = true;
    }
    
    // Users send HYPE to buy tokens
    function buyToken(string memory tokenSymbol, uint256 leverage) external payable nonReentrant whenNotPaused {
        require(msg.value > 0, "Must send HYPE to buy");
        require(leverage >= 1 && leverage <= 15, "Invalid leverage");
        
        userDeposits[msg.sender] += msg.value;
        totalDeposits += msg.value;
        
        Trade memory newTrade = Trade({
            user: msg.sender,
            tokenSymbol: tokenSymbol,
            amount: msg.value,
            isBuy: true,
            timestamp: block.timestamp,
            leverage: leverage
        });
        
        userTrades[msg.sender].push(newTrade);
        allTrades.push(newTrade);
        
        emit TradeExecuted(msg.sender, tokenSymbol, msg.value, true, leverage, block.timestamp);
        emit FundsDeposited(msg.sender, msg.value);
    }
    
    // Users can sell (no HYPE sent, just record the trade)
    function sellToken(string memory tokenSymbol, uint256 amount, uint256 leverage) external nonReentrant whenNotPaused {
        require(amount > 0, "Amount must be greater than 0");
        require(leverage >= 1 && leverage <= 15, "Invalid leverage");
        
        Trade memory newTrade = Trade({
            user: msg.sender,
            tokenSymbol: tokenSymbol,
            amount: amount,
            isBuy: false,
            timestamp: block.timestamp,
            leverage: leverage
        });
        
        userTrades[msg.sender].push(newTrade);
        allTrades.push(newTrade);
        
        emit TradeExecuted(msg.sender, tokenSymbol, amount, false, leverage, block.timestamp);
    }
    
    // Only owner can recover user funds (emergency or on user request)
    function recoverUserFunds(address user, uint256 amount) external onlyOwner nonReentrant {
        require(authorizedRecovery[msg.sender], "Not authorized for recovery");
        require(userDeposits[user] >= amount, "Insufficient user deposits");
        require(address(this).balance >= amount, "Insufficient contract balance");
        
        userDeposits[user] -= amount;
        totalDeposits -= amount;
        
        (bool success, ) = user.call{value: amount}("");
        require(success, "Transfer failed");
        
        emit FundsRecovered(user, amount, msg.sender);
    }
    
    // Owner can withdraw fees/profits (anything above user deposits)
    function withdrawFees() external onlyOwner {
        uint256 fees = address(this).balance - totalDeposits;
        require(fees > 0, "No fees to withdraw");
        
        (bool success, ) = owner().call{value: fees}("");
        require(success, "Transfer failed");
    }
    
    // Emergency functions
    function pause() external onlyOwner {
        _pause();
    }
    
    function unpause() external onlyOwner {
        _unpause();
    }
    
    function addRecoveryAgent(address agent) external onlyOwner {
        authorizedRecovery[agent] = true;
    }
    
    function removeRecoveryAgent(address agent) external onlyOwner {
        authorizedRecovery[agent] = false;
    }
    
    // View functions
    function getUserTrades(address user) external view returns (Trade[] memory) {
        return userTrades[user];
    }
    
    function getTotalTrades() external view returns (uint256) {
        return allTrades.length;
    }
    
    function getContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
    
    function getUserDeposits(address user) external view returns (uint256) {
        return userDeposits[user];
    }
    
    // Fallback to receive HYPE
    receive() external payable {
        userDeposits[msg.sender] += msg.value;
        totalDeposits += msg.value;
        emit FundsDeposited(msg.sender, msg.value);
    }
}