#lang pollen

◊(define-meta published "2021-09-12")
◊(define-meta title "Rich Statefulness With UTXOs")

Coming from the Ethereum ecoystem it's a common belief that Turing-complete smart contracts are needed to have a sufficiently powerful layer-1 (L1) blockchain. In Vitalk Buterin's post ◊(link "https://vitalik.ca/general/2019/12/26/mvb.html" "Base Layers and Functionality Escape Velocity") he lays out the requirements he believes are necessary for a blockchain in order to supp ort L2 applications effectively. Contrary to what an Ethereum maximalist might think, the Themelio UTXO model fits very well with Vitalik's requirements. Vitalik says that an L1 needs 3 things: A programming language, rich statefulness, and data scalability. 

◊(h2 "A Programming Language")
◊(epigraph "Any program in one Turing-complete language can be translated into an equivalent program in any other Turing-complete language. However, it turns out that we only need something slightly lighter: it's okay to restrict to programs without loops, or programs which are guaranteed to terminate in a specific number of steps.")

In Themelio's MelVM loops are bounded by some number N (it will run at most N times). The program counter also only moves forward on the "tape" so programs are guaranteed to terminate - making them non-Turing-complete. Why design a non-Turing-complete VM when you can have a Turing-complete one?

Well for one, the weight of a script can be determined without running the program, just by weighting each instruction and multiplying by the loop bounds. A block producer can efficiently make decisions about whether to include a transaction based on its weight. Even Bitcoin although its scripting is non-Turing-complete only measures the weight of a script ◊(link "https://en.bitcoin.it/wiki/Weight_units" "by its size in bytes"). A consequence of this is that Bitcoin nodes generally only accept transactions with known script hashes because unknown scripts are unpredictable in computational cost. So even programs that are theoretically possible in Bitcoin script may not work in application. Similarly an estimated gas amount is sent with an Ethereum transaction and if the funds are insufficient, the transaction fails.

It's also worth pointing out that in practice on the blockchain the EVM is not Turing-complete because a program is limited by the amount of gas it is provided. Its a somewhat pedantic point but I think it helps show that in a way all EVM loops are "bounded" anyway. There is also a case to be made for non-Turing-completeness as a security benefit but I haven't found very strong evidence for this. Maybe the security argument is better reframed as simply; why have something if you don't need it?


◊(h2 "Rich Statefulness")
◊(epigraph "This ability to authorize state changes without completely setting all coins in an account free, is what I mean by \"rich statefulness\". It can be implemented in many ways, some UTXO-based, but without it a blockchain is not powerful enough to implement most layer 2 protocols")

It's well known that Bitcoin is a form of money, not an embedded computer/state machine like Ethereum. In Bitcoin's UTXO model there is no way to track coins with any notion of a persistent storage like a smart contract. Themelio is different by one subtle feature that Vitalik alludes to, "Note particularly that in this model [the script] does not have access to the destination of the transaction." In Themelio a script can inspect the transaction that spends it. Although the only thing a script can do is return yes or no for whether a transaction can spend it, we can still get persistent storage and smart contracts using the "self-propagation" design pattern.

A self-propagating script is one that enforces the spending transaction to have an output with the same script hash as itself. Essentially the rules of a program are propagated through the UTXOs creating a chain of state transitions that behaves much like a smart contract. This is a very powerful design pattern and many things can be created from it like trustless-DNS, zk-rollups, even new "coins" like an ERC-20 or NFTs. It is very likely in fact the case that self-propagating machines are Turing-complete...

◊(h2 "Sufficient data scalability and low latency")
This is an easy one because computational efficiency is where UTXOs really shine. All transactions in a block can be validated in parallel. This along with a quick 30 second block time and finality consensus with ◊(link "https://eprint.iacr.org/2020/088.pdf" "Streamlet") makes for a great foundation for rollups and other L2 scaling solutions to build on.

