With Polkadot's rococo-v1 test net rolling out, the first cross-parachain message channels are starting to form. It is all very new so this document has been my attempt to understand the core concepts that motivate the Xcmp protocol, and see how real messages are constructed. It may also serve as an engineer's TL;DR.

Xcmp (Cross-Chain Message Protocol) is a way for consensus systems to communicate/operate with eachother over a shared notion of assets. The specification [lists the core concepts](https://github.com/paritytech/xcm-format#definitions) (axioms) of the protocol, such as notions of location and account types. Interestingly, an asset definition is not on the list; they are defined in terms of location/identity (see MultiAsset).

Assets in XCMP are transferred either through
1. Complete trust between systems, via a *Teleport*
2. Collatoral (derivatives) using a reserve location

A *Sovereign Account* is the notion of a consensus system controlling an account in another consensus system. This is used to define the *Reserve Location*, where an asset is backed by an asset on another consensus system (a sovereign account).

## MultiAsset
Assets are the topic of all Xcmp messages. The *MultiAsset* format is a way to refer to a single asset, or a class of assets. A single asset may be *fungible* or *nonfungible*. And is identified either abstractly or concretely.

A MultiAsset is identified by either an
[Abstract Identifier](https://github.com/paritytech/xcm-format#abstract-identifiers) - From an agreed upon global name registry.
[Concrete Identifier](https://github.com/paritytech/xcm-format#concrete-identifiers) - A relative location as a *MultiLocation*. Because of the implied hierarchy of systems in Xcmp, MultiLocations are just like file paths `../PalletInstance(3)/GeneralIndex(42)`, and are interpreted from the message recipient's perspective.

All these distinctions can be seen directly in the [MultiAsset enum definition](https://github.com/paritytech/polkadot/blob/8daf974142f1a29624e6598ccb167c0d238f7134/xcm/src/v0/multi_asset.rs#L108), and in the [spec](https://github.com/paritytech/xcm-format#format).

## Executing Xcm Messages
Within the Polkadot repo, the xcm-executor package will interpret and run messages. To run a cross-chain message in a pallet:
1. Define the Xcm message as a data type ([source code](https://github.com/paritytech/polkadot/blob/8daf974142f1a29624e6598ccb167c0d238f7134/xcm/src/v0/mod.rs#L64) and [spec](https://github.com/paritytech/xcm-format#xcm-message-types)).
2. Pass the message into xcm-executor's [execute_xcm(origin, msg)](https://github.com/paritytech/polkadot/blob/10b0d793302d20e8fbe78b13d5be4d662380ae72/xcm/xcm-executor/src/lib.rs#L38). All messages need an origin to execute, which is a MultiLocation.

The `execute_xcm` function is very helpful to understand what is happening on each message type.

## Chaining Messages
Xcm must handle any number of hops between systems, and also needs a notion of sequence - after this, do that. To accomplish this, Xcm makes a distinction between *messages* and *orders*.
* Messages are the first instruction in an Xcm chain. They do something and place the resulting assets into a *Holding Account*, which is like a temporary buffer.
* Orders operate on assets in a holding account, and so are only used after an initial message.

Messages (and orders) that have *effects* can chain orders; just like callbacks.

## Concrete Example
From the orml pallet, xtokens, here is an Xcm message to move DOT from a parachain to the relay-chain. More specifically, redeem the parachain's local representation of DOT for real DOT in a *reserve location* on the relay-chain, to a relay-chain account.

[[Source Code Link](https://github.com/open-web3-stack/open-runtime-module-library/blob/06d37423846b986c2fc4880c2427bd2a0e71137d/xtokens/src/lib.rs#L130)]
```rust
let xcm = Xcm::WithdrawAsset {
	assets: vec![MultiAsset::ConcreteFungible {
		id: Parent.into(),
		amount: T::ToRelayChainBalance::convert(amount),
	}],
	effects: vec![Order::InitiateReserveWithdraw {
		assets: vec![MultiAsset::All],
		reserve: Parent.into(),
		effects: vec![Order::DepositAsset {
			assets: vec![MultiAsset::All],
			dest: AccountId32 {
				network: T::RelayChainNetworkId::get(),
				id: T::AccountId32Convert::convert(dest.clone()),
			}.into(),
		}],
	}],
};
```

This datatype-as-code is saying
1. Withdraw `amount` from the origin location, of the origin's asset which is concretely identified as the origin's parent chain's native token (DOT). Place into holding for further instruction. *[Executed at the origin location]*
2. Withdraw the holding asset's underlying *reserve* asset on the parent chain and put into holding. *[Executed partially at origin and partially at parent location]*
3. Deposit the reserve asset into the `dest` account within the same consensus system. *[Executed at the parent (relay-chain) location]*

It's worth noting this code could be generic to any parent and origin, except that the final AccountId32 specifies the `network` to be the relay-chain id, which constrains it to only that use case.