# Vulnérabilité Naive Receiver

## Résumé
Exploitation d'un contrat FlashLoanReceiver vulnérable qui n'impose pas de restrictions sur qui peut initier un prêt flash, permettant de vider le contrat via des frais fixes excessifs.

## Impact
- Sévérité: Élevée
- Complexité d'exploitation: Faible
- Impact financier: Perte totale des fonds du contrat receveur

## Contenu
- [Analyse détaillée](./vulnerability.md)
- [Code d'exploitation](./exploit.js)
- [Mesures préventives](./prevention.md)