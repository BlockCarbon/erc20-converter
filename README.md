# ERC20-Converter

Simple to use, decentralized, secure conversion of ERC-20 carbon tokens meeting specification into BlockCarbon tokens on Cardano. Liquidity boost for developing carbon market.
***
![alt text](https://blockcarbon.io/images/pic01.jpg "©2023 BlockCarbon Foundation MTÜ")

## Motivation
BlockCarbon offers an independent and non-profit approach to carbon credit standard and tokenization. It's preferred blockchain is Cardano which offers superior security, lower costs and better scalability than Ethereum. Existing projects that have been retired and tokenized as ERC-20 tokens can to avoid double counting not easily move between blockchains.

Holders of ERC-20 carbon tokens might consider migrating to the Cardano blockchain for a vast number of reasons:

* Lower Transaction Fees: Cardano often touts lower transaction fees compared to Ethereum, especially during network congestion periods.

* Scalability: Cardano uses the Ouroboros Proof-of-Stake protocol, which aims to achieve higher throughput and scalability compared to Ethereum's current Proof-of-Work (though Ethereum is transitioning to Proof-of-Stake).

* Sustainability: Cardano's emphasis on a more energy-efficient Proof-of-Stake mechanism makes it a more eco-friendly choice compared to traditional Proof-of-Work blockchains.

* Formal Verification: Cardano's emphasis on formal methods and formal verification seeks to offer higher assurance of smart contract correctness.

* Interoperability: Cardano is building its platform with a focus on interoperability with other blockchains, aiming to create a more interconnected ecosystem.

* Governance: Cardano has a built-in governance system (Project Catalyst) that allows token holders to have a say in the future development and funding of projects on the platform.

* Research-Driven Approach: Cardano's development process is heavily research-driven, with many of its protocols and mechanisms peer-reviewed.

* Native Tokens: Cardano supports native tokens without the need for smart contracts, aiming for simpler token mechanics and reduced complexity and fees.

* Security: Cardano claims enhanced security through its extended UTXO model, which offers certain advantages over the account-based model in Ethereum.

* Rich Contract Model: With the introduction of Plutus smart contracts, Cardano aims to offer a more flexible and powerful contract environment.


### ERC-20 Converter Flow
![alt text](https://blockcarbon.io/images/erc20flow.png "Ideal Flow of ERC-20 Conversion")

### Fountain-agnostic implementation
Instead of relying on any specific API or token distribution network, proof-of-burn and proof-of-lock solidity code for whitelisted token addresses can be used to verify eligibility.

### How the website works
There is a dedicated landing page that can use a deployment script and facilitate conversion. 

[BlockCarbon ERC-20 Converter Landing page](https://blockcarbon.io/erc20.html)

### How the script works
From an adverse selection point of view, it is highly likely that the owner of a Cardano address might spoof ownership or burning of ERC-20 tokens they do not own in order to obtain "free" Cardano tokens. It is highly unlikely that the owner of EVM ERC-20 tokens will "maliciously" burn their own tokens. Therefore, the proof of web3 wallet access needs to be provided through MetaMask and will unlock a Cardano redemption. The simplest implementation is through JavaScript script that can be triggered directly inside the web browser, but more secure deployment using TypeScript and Hardhat, or an Ethereum DApp are also possible within the project.

### Smart contracts
Users should intensively test on the Sepolia and Preview Testnets using the Remix Injected Provider - MetaMask functionality before deploying any Solidity code live.

[Remix Injected Web3](https://remix.ethereum.org/#optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.7+commit.e28d00a7.js&lang=en
)

### Decentralization vs security trade-offs
Exchanging tokens between Ethereum and Cardano using the ERC-20 converter involves making certain trade-offs between decentralization and security. Let's delve into the trade-offs and some potential designs.

* 1. Trade-offs:
Decentralization: In the context of an ERC-20 converter, decentralization refers to how much trust and control are distributed across network participants. A fully decentralized system would not rely on any centralized party to verify and authorize conversions.

Security: This encompasses the robustness of the system against attacks and fraud. If a centralized party is involved, what measures are in place to ensure that this party cannot commit fraud or become a single point of failure?

* 2. Designs:
Fully Centralized: One straightforward design involves a centralized bridge where users send their Ethereum-based tokens, and the service mints the corresponding Cardano tokens (and vice versa). While this method can be fast and efficient:

Security: It's vulnerable because there's a single point of failure.
Decentralization: It's highly centralized, meaning users need to trust the service.
Collateral-Based: This design involves participants locking up collateral (either on Ethereum or Cardano). If they act maliciously or fail to honor conversions, their collateral is slashed.

Security: High, assuming the value of collateral is significantly greater than the volume of conversions.
Decentralization: Reasonably decentralized, but depends on the number and diversity of collateral providers.
Multi-Signature & Federated Bridges: A group of known and reputable entities (validators) manages the bridge. Transactions need signatures from a majority (or other threshold) of these entities to proceed.

Security: Vulnerabilities decrease with more validators, but coordination becomes more complex.
Decentralization: Somewhat centralized since the bridge relies on a specific group of validators.
Relay or Notary Schemes: These involve witnesses or notaries attesting to events on one chain so they can be mirrored on the other.

Security: Depends on the number and honesty of relayers/notaries.
Decentralization: Can be highly decentralized if there are many independent notaries.

* 3. Sensible Mix:
The ideal design likely combines elements from various models to balance security and decentralization. A federated bridge with a large, diverse set of validators combined with a collateral mechanism can provide a good mix. Validators ensure the correct operation of the bridge, while collateral provides economic incentives for honesty.

### Scale and overheads
Ideally, a trusted token distribution provider can be used for the user's needs. DripDropz provides token dispensing services to the Cardano community. A certain critical mass of token expected to exchanged might be required to justify the upfront costs of the DripDropz API (coming soon).

[About DripDropz](https://dripdropz.io/about-us)


### Milkomeda as an alternative
Milkomeda wrapped smart contract to bridge ERC-20 tokens directly:

[Development overview using npm/javascript and Flint/MetaMask wallets](https://docs.milkomeda.com/cardano/wrapped-smart-contracts/developers/dev_overview)


[Solidity contracts can interact with Cardano via Milkomeda](https://docs.milkomeda.com/cardano/wrapped-smart-contracts/developers/how_to_integrate)

##### This requires manually setting up Milkomeda as a network inside MetaMask

* Network Name: Milkomeda Cardano (C1)

* New RPC URL: https://rpc-mainnet-cardano-evm.c1.milkomeda.com

* Chain ID: 2001

* Currency Symbol: mADA

* Block Explorer URL: https://explorer-mainnet-cardano-evm.c1.milkomeda.com
