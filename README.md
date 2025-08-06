# HyperEVM Perpetual

A professional token trading platform exclusively for the HyperEVM ecosystem (Chain ID: 999). Trade HYPE tokens with up to 15x leverage using authentic DexScreener data and real-time blockchain integration.

## Features

- **HyperEVM Exclusive**: Focused solely on Hyperliquid's HyperEVM blockchain
- **Real Trading**: MetaMask integration with actual HYPE token transfers
- **Professional Interface**: TradingView-style charts and professional trading modal
- **Leverage Trading**: Up to 15x leverage with position management
- **Authentic Data**: Real token data from DexScreener with verified logos and pricing
- **Smart Contract**: Deployed contract for secure fund management

## Live Deployment

🚀 **Website**: [hyperevm-perpetual.vercel.app](https://hyperevm-perpetual.vercel.app)

## Contract Information

- **Contract Address**: `0xf96dd9f99c9bb2b40fbdc17e0ede7c3bfe50656c`
- **Network**: HyperEVM Mainnet (Chain ID: 999)
- **Explorer**: [View on HyperEVM Scan](https://hyperevmscan.io/address/0xf96dd9f99c9bb2b40fbdc17e0ede7c3bfe50656c)

## Technology Stack

- **Frontend**: React 18 with vanilla JavaScript
- **Styling**: Tailwind CSS
- **Blockchain**: Web3.js with MetaMask integration
- **Smart Contracts**: Solidity on HyperEVM (`HyperEVMPerpetual.sol`)
- **Data Sources**: DexScreener API for authentic token data
- **Deployment**: Vercel with optimized static configuration

## Getting Started

1. Clone the repository
2. Deploy to Vercel or serve `index.html` locally
3. Connect your MetaMask wallet to HyperEVM
4. Start trading HYPE tokens with leverage

## Contract Details

**Source Code**: `HyperEVMPerpetual.sol`
**Functions**:
- `receive()` - Automatically collects HYPE from users
- `withdrawAllFunds()` - Owner withdraws all accumulated funds
- `getContractBalance()` - View current contract balance

## Network Configuration

Add HyperEVM to MetaMask:
- **Network Name**: HyperEVM
- **RPC URL**: https://rpc.hyperliquid.xyz/evm
- **Chain ID**: 999
- **Currency Symbol**: HYPE
- **Block Explorer**: https://hyperevmscan.io/

## Security Notice

⚠️ **Important**: This platform transfers user funds to the deployed smart contract. All HYPE token trades are recorded on-chain with EIP-712 signatures for security.

## License

MIT License - Built for the HyperEVM ecosystem