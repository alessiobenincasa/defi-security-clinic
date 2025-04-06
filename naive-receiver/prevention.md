# Recommandations de sécurité

## Problème fondamental
Le contrat `FlashLoanReceiver` ne limite pas qui peut initier un prêt flash en son nom, le rendant vulnérable à des drainages de fonds via les frais.

## Solutions recommandées

### Solution 1: Authentification de l'initiateur
```solidity
// Dans FlashLoanReceiver
address private owner;

constructor(address payable poolAddress) public {
    pool = poolAddress;
    owner = msg.sender;
}

// Dans receiveEther
function receiveEther(uint256 fee) public payable {
    require(msg.sender == pool, "Sender must be pool");
    require(tx.origin == owner, "Only owner can initiate flash loans");
    
    // Reste de la fonction inchangé
}
```

### Solution 2: Utiliser un frais proportionnel plutôt que fixe
```solidity
// Dans NaiveReceiverLenderPool
uint256 private constant FEE_PERCENT = 1; // 1% fee

function flashLoan(address payable borrower, uint256 borrowAmount) external nonReentrant {
    uint256 fee = borrowAmount.mul(FEE_PERCENT).div(100);
    // Reste de la fonction avec ce fee variable
}
```

### Solution 3: Limiter la fréquence des emprunts
```solidity
// Dans FlashLoanReceiver
uint256 public lastBorrowTime;
uint256 public constant COOLDOWN = 1 hours;

function receiveEther(uint256 fee) public payable {
    require(msg.sender == pool, "Sender must be pool");
    require(block.timestamp >= lastBorrowTime + COOLDOWN, "Borrowing too frequently");
    
    lastBorrowTime = block.timestamp;
    // Reste de la fonction inchangé
}
```

## Principes de conception sécurisée
- Ne jamais supposer que l'appelant est bienveillant
- Toujours vérifier qui peut initier des actions coûteuses
- Limiter les frais fixes qui peuvent être exploités en répétition
- Mettre en place des limites de fréquence pour les opérations critiques