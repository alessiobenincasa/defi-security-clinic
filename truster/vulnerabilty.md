# Vulnerability Analysis - Truster

## Context
The TrusterLenderPool contract allows borrowing tokens via a flash loan, and during this loan, it can also execute an arbitrary call to a target address with data specified by the caller.

## Attack Vector
The `flashLoan` function of the pool allows the caller to specify:
1. A target address (`target`)
2. Arbitrary call data (`data`)

The problem is that the contract executes this arbitrary call on behalf of the pool itself:
```solidity
target.functionCall(data);
```

This allows an attacker to have the pool execute any call, including:
- Approving the attacker to spend the pool's tokens
- Modifying critical parameters
- Executing functions reserved for the pool

## Technical Details
1. The attacker encodes a call to the token's `approve(attacker, TOKENS_IN_POOL)` function
2. They call `flashLoan` with:
   - Borrowed amount = 0 (no need to actually borrow)
   - Target = token address
   - Data = encoded call to approve()
3. The pool unwittingly executes the approval, giving the attacker the right to spend its tokens
4. The attacker then uses `transferFrom` to take all tokens from the pool

## Attack Flow Diagram
[See diagram](./diagram/truster-flow.png)