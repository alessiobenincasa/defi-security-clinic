# Analyse de la vulnérabilité - Truster

## Contexte
Le contrat TrusterLenderPool permet d'emprunter des tokens via un prêt flash (flashloan), et durant ce prêt, il peut également exécuter un appel arbitraire à une adresse cible avec des données spécifiées par l'appelant.

## Vecteur d'attaque
La fonction `flashLoan` du pool permet à l'appelant de spécifier:
1. Une adresse cible (`target`)
2. Des données d'appel arbitraires (`data`)

Le problème est que le contrat exécute cet appel arbitraire au nom du pool lui-même:
```solidity
target.functionCall(data);
```

Cela permet à un attaquant de faire exécuter n'importe quel appel par le pool, y compris:
- Approuver l'attaquant à dépenser les tokens du pool
- Modifier des paramètres critiques
- Exécuter des fonctions réservées au pool

## Détails techniques
1. L'attaquant encode un appel à la fonction `approve(attacker, TOKENS_IN_POOL)` du token
2. Il appelle `flashLoan` avec:
   - Montant emprunté = 0 (pas besoin d'emprunter réellement)
   - Target = adresse du token
   - Data = appel encodé à approve()
3. Le pool exécute involontairement l'approbation, donnant à l'attaquant le droit de dépenser ses tokens
4. L'attaquant utilise ensuite `transferFrom` pour prendre tous les tokens du pool

## Diagramme du flux d'attaque
[Voir diagramme](./diagrams/truster-flow.png)