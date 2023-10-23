// _app,tsx

import '@/styles/globals.css'
import type { AppProps } from 'next/app'

import { WagmiConfig, createClient } from "wagmi";
import {
  ConnectWSCProvider,
  getDefaultConfig,
  MilkomedaNetworkName,
} from "milkomeda-wsc-ui-test-beta";

const client = createClient(
  getDefaultConfig({
    oracleUrl: "https://wsc-server-devnet.c1.milkomeda.com",
    blockfrostId: "<BLOCKFROST_KEY>",
    network: MilkomedaNetworkName.C1Devnet,
    cardanoWalletNames: ["flint"], // , "eternl", "nami", "nufi", "yoroi"
  })
);


export default function App({ Component, pageProps }: AppProps) {
  return (
    <WagmiConfig client={client}>
      <ConnectWSCProvider>
        <Component {...pageProps} />
      </ConnectWSCProvider>
    </WagmiConfig>
  );
}