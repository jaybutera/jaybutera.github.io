#lang pollen

◊(define-meta published "2022-03-22")
◊(define-meta title "Turing Completeness In UTXOs")

The UTXO model is the foundational paradigm for tracking ownership in a blockchain. UTXOs, also called coins, protect their value from being spent with a script which determines whether a spender is authorized or not. These scripts allow for some interesting constructions like multi-sig contracts. But they are simple compared to the smart contracts you find in Ethereum or other account-based representations.

In fact coin scripts like Bitcoin and Themelio are not Turing-complete. Meaning not all possible computations can be done in a coin scipt. However I'm going to show here that by simply adding the ability for a coin to inspect its spending transaction, called ◊(link "https://fc16.ifca.ai/bitcoin/papers/MES16.pdf" "covenants"), smart contracts are Turing-complete over the span of multiple spends of a coin.

To prove Turing-completeness of a system, it suffices to show that a Turing machine can be simulated within it. We will define a covenant which acts as the state transition function and use coin metadata (which is simply an undefined-size byte array in Themelio), to store state across transitions. We'll start with a definition of a Turing machine ◊(link "https://en.wikipedia.org/wiki/Turing_machine#Formal_definition" "from Wikipedia"). The wikipedia formatting is a little cleaner if you want to just look there.

◊(h2 "Definition of a Turing Machine")

A Turing machine can be formally defined as a 7-tuple M=<Q,L,b,E,d,q,F> where

- L is a finite, non-empty set of tape alphabet symbols;

- b in L is the blank symbol (the only symbol allowed to occur on the tape infinitely often at any step during the computation);

- The subset E of L is the set of input symbols, that is, the set of symbols allowed to appear in the initial tape contents;

- Q is a finite, non-empty set of states;

- q in Q is the initial state;

- subset F of Q is the set of final states or accepting states. The initial tape contents is said to be accepted by M if it eventually halts in a state from F.

- d: (Q\F) x L -> Q x L x {Left,Right} is a partial function called the transition function, where Left is left shift, Right is right shift. If d is not defined on the current state and the current tape symbol, then the machine halts; intuitively, the transition function specifies the next state transited from the current state, which symbol to overwrite the current symbol pointed by the head, and the next head movement.


For some definition M, execution is the continuous evaluation of d. More intutively, there is a "head" which points to a specific symbol on a sequence of symbols called the tape. Each transition the head reads the symbol and from that, chooses to write the tape, move right or left, and transition to a new internal state in Q.


◊(h2 "Simulating M in a Covenant Script")

To simulate a Turing machine we start by storing the head index h, the current state q, and the tape in the metadata of a coin. The script of this coin reads the value on the tape at h, tape[h] = v. Based on v we add or subtract one from h, change the state q->q', and write v->v' at tape[h].

There is one caveat that coins cannot actually write to their memory. They can't modify the metadata in a spending coin. So instead of writing, the script is constraining the spending coin metadata to be the correct state so that only the state which the Turing machine would theoretically write can be the succeeding state.

The explanation above is complete but for assured-ness I wrote a covenant in melodeon with an example Turing machine. The formatting is better ◊(link "https://github.com/jaybutera/turing-covenant/blob/master/turing-machine.melo" "on github") (or download it and use a python syntax highlighter).


let data = unsafe env_parent_data() :! [{0}, Nat, %[100]],
    # Parse apart the coin data
    head = data[0],
    cur_state = data[1],
    tape = data[2],
    v = tape[head],
    # Spender coin
    spender_cov_coin = unsafe vref(env_spender_tx().outputs, 0) :! CoinData,
    spender_data = unsafe spender_cov_coin.additional_data :! %[100],
    # Expected values for the spending coin's data
    # The rules of the state transition function are specified here
    next_head = if v: head+1 else head-1,
    next_state = if cur_state && v: 0 else 1,
    # At tape[head]: 0 -> 0, 1 -> 0
    rest = blen(tape)-1 - head,
    next_tape =
        if v: b_slice(tape, 0, head) ++ %[0] ++ b_slice(tape, head, unsafe rest :! {0})
        else tape in

    # Check that script is perpetuated in spender
    spender_cov_coin.covhash == env_self_hash()
    && spender_data == [
        next_head,
        next_state,
        next_tape,
    ]





◊(h2 "Completing the Theoretical Picture")

Now I should point out that it is important theoretically that the size of the tape is infinite (in order for computation to be unbounded). Practically speaking the above definition is as Turing-complete as an Ethereum smart contract, whose computation is also bounded by the amount of gas in a transaction. But for theoretical completeness we can modify the implementation to a less convenient-for-explaining but actually infinite model.

To make the tape infinite, we no longer can store the tape in metadata memory. Instead we keep the (infinite) tape outside the blockchain and feed the symbol tape[h] in as metadata in the spending transaction. Consider this for a moment, it may seem like cheating that the infinite storage is not on the chain. But in practice there is no infinite storage, for instance on your hard drive. Still this model is more feasibly infinite.

◊(h2 "Concluding Remarks")

You may wonder whether its actually useful that a Turing machine can be simulated with covenants. The answer is definitely not. Just like its not really useful to simulate a Turing machine on a computer. The purpose of simulating is to show that the model is general enough to perform any computation, as a Turing machine can. Being able to simulate a Turing machine basically answers the question "I wonder if I could implement X as a smart contract in a UTXO covenant." By the results here, the answer to that question is definitely yes.
