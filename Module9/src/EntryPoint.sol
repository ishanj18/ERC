// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./SmartWallet.sol";

contract EntryPoint {
    function executeUserOperation(
        address wallet,
        address target,
        uint256 value,
        bytes calldata data
    ) external {
        SmartWallet(payable(wallet)).execute(target, value, data);
    }
}
