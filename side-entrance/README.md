# Side Entrance Vulnerability

## Summary
Exploitation of a vulnerability in a lending pool that allows an attacker to use flashloans to create a fictitious deposit, then withdraw all funds from the pool via the deposit/withdrawal system.

## Impact
- Severity: Critical
- Exploitation complexity: Medium
- Financial impact: Total loss of pool funds

## Contents
- [Detailed Analysis](./vulnerability.md)
- [Exploit Code](./exploit.js)
- [Attacker Contract](./SideEntranceAttacker.sol)
- [Preventive Measures](./prevention.md)