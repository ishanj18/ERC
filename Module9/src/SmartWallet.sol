// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SmartWallet {
    address public owner;

    mapping(address => bool) public guardian;
    mapping(address => uint256) public recoveryVotes;

    uint256 public constant REQUIRED_VOTES = 2;

    constructor(address _owner, address[] memory guardians) {
        owner = _owner;

        for (uint256 i = 0; i < guardians.length; i++) {
            guardian[guardians[i]] = true;
        }
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function execute(
        address target,
        uint256 value,
        bytes calldata data
    ) external onlyOwner {
        (bool success, ) = target.call{value: value}(data);

        require(success, "Call failed");
    }

    function recoverOwner(address newOwner) external {
        require(guardian[msg.sender], "Not guardian");

        recoveryVotes[newOwner]++;

        if (recoveryVotes[newOwner] >= REQUIRED_VOTES) {
            owner = newOwner;
        }
    }

    receive() external payable {}
}
