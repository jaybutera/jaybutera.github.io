#lang pollen

◊(define-meta published "2021-04-30")
◊(define-meta title "Blockchain Analogies")

In 2008 Satoshi Nakamoto proposed a solution to a problem they observed in society. That problem, was a failure of the legal system, designed by society, to be executed faithfully. As an alternative to the current methods for execution of law, Nakamoto saw a blockchain as the better authoritative source. One that would faithfully track ownership as it was designed, and would maintain a more stable accounting of the money supply.

Interestingly, logic itself was perhaps a similar endeavor when originally concieved by Aristotle. He was looking for a way to draw conclusions from true premises such that the truth was preserved. The premise of an axiomatic system is that, starting from things that are known to be true, new truths can be derived through inference - composition of more basic truths. Each new truth, or theorem, is derived from within the system, and so it can be trusted as much as the original axioms.

That should sound familiar. Satoshi’s blockhain, like an axiomatic system, provides a universe of possibilities from a root of trust. Theorems of a formal system are analogous to UTXOs on a blockchain (the connection can be defined as more than just analogy, considering the Curry-Howard correspondence to mathematical logic). UTXOs are the current state. They represent who owns what. In general, we trust that people legitamately obtained coins of a UTXO by the method defined by the blockchain protocol, as much as we trust the blockchain protocol itself. That is, that miners are incentivized to execute the protocol honestly without too much collusion.

This is the axiom-of-trust of a blockchain. From it, we derive an entire system of ownership. People call this executable law, but this seems like a non sequitur since all law should be executed faithfully. Conversely, all code is executable logic when connected by the aformentioned correspondence. It may make more sense to be called executable “law-gic”. A logic for our legal system.
