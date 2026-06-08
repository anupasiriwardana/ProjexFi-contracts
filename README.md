# ProjexFi Contracts

This repository contains the core smart contracts and the Hardhat development environment for **ProjexFi**, a trustless Web3 crowdfunding and yield platform.

> **⚠️ IMPORTANT: Deployment & Setup**
> This repository is a microservice part of the larger ProjexFi ecosystem. 
> To run this project, boot the local blockchain, and deploy the containers, please refer to the master initialization guide in the **[ProjexFi Root Repository](https://github.com/anupasiriwardana/ProjexFi)**.

## 🛠 Tech Stack
* **Solidity:** Smart contract development.
* **Hardhat:** Ethereum development environment for compiling, deploying, and testing.
* **TypeScript:** Scripting and configuration.
* **Ethers.js (v6):** Blockchain interaction library.

## 📁 Repository Structure
* `/contracts` - Contains the raw `.sol` smart contracts (e.g., `RevenueRouter.sol`).
* `/ignition/modules` - Contains Hardhat Ignition deployment scripts.
* `/test` - Contains automated tests for contract logic and math.
* `hardhat.config.ts` - Hardhat network and compiler configuration.

## 💻 Local Development Commands
If you are developing smart contracts outside of the Docker environment, you can use the following commands:

```bash
# Compile smart contracts and generate the ABI (artifacts folder)
npx hardhat compile

# Run the automated test suite
npx hardhat test

# Spin up a local ephemeral node
npx hardhat node

# Deploy to the local node
npx hardhat ignition deploy ./ignition/modules/RevenueRouter.ts --network localhost
```


### Make a deployment to Sepolia (Additional)

This project includes an example Ignition module to deploy the contract. You can deploy this module to a locally simulated chain or to Sepolia.

To run the deployment to a local chain:

```shell
npx hardhat ignition deploy ignition/modules/Counter.ts
```

To run the deployment to Sepolia, you need an account with funds to send the transaction. The provided Hardhat configuration includes a Configuration Variable called `SEPOLIA_PRIVATE_KEY`, which you can use to set the private key of the account you want to use.

You can set the `SEPOLIA_PRIVATE_KEY` variable using the `hardhat-keystore` plugin or by setting it as an environment variable.

To set the `SEPOLIA_PRIVATE_KEY` config variable using `hardhat-keystore`:

```shell
npx hardhat keystore set SEPOLIA_PRIVATE_KEY
```

After setting the variable, you can run the deployment with the Sepolia network:

```shell
npx hardhat ignition deploy --network sepolia ignition/modules/RevenueRouter.ts
```
