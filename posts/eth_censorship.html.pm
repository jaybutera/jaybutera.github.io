#lang pollen

◊(define-meta published "2022-08-20") ◊(define-meta title "Censorhsip and the Fragility of Ethereum")

The ◊(link "https://blog.bitmex.com/ofac-sanctions-ethereum-pos-some-technical-nuances/" "article by BitMEX Research") covers two major choices of censorship for Ethereum validators post-merge.

1. Refuse to include OFAC banned transactions in blocks you produce
2. Refuse to build on top of a chain that includes OFAC banned transactions

These seem like reasonable actions for validators to take in the face of participating in illegal activity. Tor exit node operators have been ◊(link "https://www.quora.com/Are-Tor-exit-node-operators-legally-responsible-if-someone-does-something-illegal-while-using-their-exit-node" "known to be liable") for the traffic they relay; to be enforced when the government desires.

"The staker is voting on a source block, a target block and a head block, and in theory, what the staker is actually attesting to is all transactions between the last finalised block and the head block. The fact that the head block is referenced in the attestation is merely a technicality."

A blockchain is a way to serialize transactions into sequential blocks. The blocks are only the serialization format. The attestations in consensus represent a vote for the chain (all historical blocks), not just the latest. It seems very unlikely the law will miss this nuance between a vote for the latest block and voting for all blocks in the chain.

So the choice is really whether to comply with OFAC sanctions or not to. To refuse to vote for a canonical chain which contains Tornado transactions (to comply), means a portion of your stake will get slashed for not participating in consensus.

But only if it is a canonical chain. If greater than 2/3 of staked Eth complies then non-complicit validators' blocks will never be validated and complicit validators won't be penalized for censorship.

Looking at the [current pool distribution](https://beaconcha.in/pools) it would be sufficient to censor the network if just the lido, coinbase, kraken and binance pools comply with sanctions.

If they all apply sanctions at once there's a good chance no one would flinch and the chain would successfully be censored. Since in the default non-complicit state of the network, validators are incentivized to not censor or else face slashing penalties, it's unlikely that any single major pool will want to apply sanctions alone.

Whether these four pools could work together to save their own liabilities and keep their stakers may be up to the only decentralized pool, Lido, which is operated by a DAO. However with the recent ◊(link "https://twitter.com/RyanSAdams/status/1558044593937170433" "arrest of Alexey Pertsev") DAO-ification is looking like a weak defense from legal liability.


