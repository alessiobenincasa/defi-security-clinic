# Security Recommendations

## Fundamental Problem
The `FlashLoanReceiver` contract does not limit who can initiate a flash loan on its behalf, making it vulnerable to fund draining through fees.

## Recommended Solutions

### Solution 1: Initiator Authentication
```solidity
// In FlashLoanReceiver
address private owner;

constructor(address payable poolAddress) public {
    pool = poolAddress;
    owner = msg.sender;
}

// In receiveEther
function receiveEther(uint256 fee) public payable {
    require(msg.sender == pool, "Sender must be pool");
    require(tx.origin == owner, "Only owner can initiate flash loans");
    
    // Rest of the function unchanged
}
```

### Solution 2: Use a Proportional Fee Rather Than Fixed
```solidity
// In NaiveReceiverLenderPool
uint256 private constant FEE_PERCENT = 1; // 1% fee

function flashLoan(address payable borrower, uint256 borrowAmount) external nonReentrant {
    uint256 fee = borrowAmount.mul(FEE_PERCENT).div(100);
    // Rest of the function with this variable fee
}
```

### Solution 3: Limit Borrowing Frequency
```solidity
// In FlashLoanReceiver
uint256 public lastBorrowTime;
uint256 public constant COOLDOWN = 1 hours;

function receiveEther(uint256 fee) public payable {
    require(msg.sender == pool, "Sender must be pool");
    require(block.timestamp >= lastBorrowTime + COOLDOWN, "Borrowing too frequently");
    
    lastBorrowTime = block.timestamp;
    // Rest of the function unchanged
}
```

## Secure Design Principles
- Never assume the caller is benevolent
- Always verify who can initiate costly actions
- Limit fixed fees that can be exploited through repetition
- Implement frequency limits for critical operations