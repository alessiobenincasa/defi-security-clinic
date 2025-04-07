# Truster Vulnerability

## Summary
Exploitation of a vulnerability in TrusterLenderPool that allows an attacker to use the flashLoan function to execute an arbitrary call to the token contract, leading to theft of all funds from the pool.

## Impact
- Severity: Critical
- Exploitation complexity: Medium
- Financial impact: Total loss of pool funds

## Contents
- [Detailed Analysis](./vulnerabilty.md)
- [Exploit Code](./exploit.js)
- [Preventive Measures](./prevention.md)
- [Attack Flow Diagram](./diagram/truster-flow.png)