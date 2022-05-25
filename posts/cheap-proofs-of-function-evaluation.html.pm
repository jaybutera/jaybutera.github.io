#lang pollen

◊(define-meta published "2022-05-25")
◊(define-meta title "Cheap Proofs of Function Evaluation")

Suppose you have a really complicated function that takes alot of processing
power, or storage, to compute. You can't run it on your computer so you
need to pay a provider to run it for you. Suppose this is a well known function
and there are providers who will run your inputs and give you the outputs for a
price.

How do you know that the result they give you, y, is the result of running your
input, z, on this well known function f; f(z)=y?

The provider could arithmetize the input and the execution of the circuit and
provide you with a polynomial commitment proof (Plonk) that they have knowledge
of said circuit. And then provide a proof that f(z)=y.

But since the function f is really complex, so is the proof generation and it
becomes very costly (think at least double the cost of just running the
function) to prove every evaluation on different inputs.

If you have a way to verify that a commitment is indeed a commitment to f, then
you could use the elliptic curve pairing to check that f(z)=y as is done in
KZG.

In a snark, both the prover and verifier have knowledge of the circuit
(although only the prover knows the witness). But in this scenario the verifier
won't have knowledge of the circuit because it is very large and complex.
Instead the verifier just needs to be reasonably sure that the commitment to f
indeed reflects f.

Suppose there is an MPC computation to construct f in a verifiable way
(although verification will require downloading f and checking the construction
proofs). This computation will require staking of crypto tokens in a challenge
period so that actors involved in the construction are incentivized to report
eachother for false proofs of construction.

Unless all actors collude to not report eachother (where any one actor could
otherwise get the entire stake of all the malicious colluders), we can be
reasonably sure the produced function f and its commitment are constructed correctly.

Consider this MPC construction of f and commitment to f to be like a PKI public
key made a by a trusted friend. Once you know it, they can "encrypt" messages
using it, or in this case, evaluate results f(z)=y which you can verify using
KZG with the MPC commitment to f.

This may find many uses in distributed scientific computing. Where a
distributed group (or individual) run a simulation, or perhaps train a very large AI in a
distributed and verifiable fashion (using zk-snarks on backpropagation for
example). Then from the result of the simulation, users/customers can make
queries which will be evaluated on the model and results returned along with a
cheap proof.
