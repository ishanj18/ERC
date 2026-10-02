// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC777/IERC777Recipient.sol";
import "@openzeppelin/contracts/interfaces/IERC1820Registry.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract TokenRecipient is IERC777Recipient, ReentrancyGuard {
    IERC1820Registry constant registry =
        IERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24);

    bytes32 constant TOKENS_RECIPIENT_INTERFACE_HASH =
        keccak256("ERC777TokensRecipient");

    uint256 public totalReceived;

    constructor() {
        registry.setInterfaceImplementer(
            address(this),
            TOKENS_RECIPIENT_INTERFACE_HASH,
            address(this)
        );
    }

    function tokensReceived(
        address,
        address,
        address,
        uint256 amount,
        bytes calldata,
        bytes calldata
    ) external override nonReentrant {
        totalReceived += amount;
    }
}
