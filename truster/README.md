# Vulnérabilité Truster

## Résumé
Exploitation d'une vulnérabilité dans TrusterLenderPool qui permet à un attaquant d'utiliser la fonction flashLoan pour exécuter un appel arbitraire au contrat de token, menant au vol de tous les fonds du pool.

## Impact
- Sévérité: Critique
- Complexité d'exploitation: Moyenne
- Impact financier: Perte totale des fonds du pool

## Contenu
- [Analyse détaillée](./vulnerability.md)
- [Code d'exploitation](./exploit.js)
- [Mesures préventives](./prevention.md)