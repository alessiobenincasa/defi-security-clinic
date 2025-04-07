# Naive Receiver Vulnerability

## Summary
Exploitation of a vulnerable FlashLoanReceiver contract that does not impose restrictions on who can initiate a flash loan, allowing the contract to be drained through excessive fixed fees.

## Impact
- Severity: High
- Exploitation complexity: Low
- Financial impact: Total loss of receiver contract funds

## Contents
- [Detailed Analysis](./vulnerability.md)
- [Exploit Code](./exploit.js)
- [Preventive Measures](./prevention.md)
- [Attack Flow Diagram](./diagrams/naive-receiver.png)