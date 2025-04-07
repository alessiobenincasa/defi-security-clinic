# The Rewarder - Vulnerability Analysis

## Overview
This repository contains a security analysis of the "The Rewarder" challenge from Damn Vulnerable DeFi. It demonstrates a critical vulnerability in reward distribution systems that use balance snapshots without proper timelock mechanisms.

## Contents
- `exploit.js`: Proof of concept exploit code
- `vulnerability.md`: Detailed explanation of the vulnerability
- `prevention.md`: Security recommendations and prevention techniques
- `diagrams/`: Visual representations of the attack vectors

## Impact
This vulnerability potentially allows an attacker to drain reward tokens through flash loan manipulation, severely impacting the economics of any protocol using similar reward mechanisms.