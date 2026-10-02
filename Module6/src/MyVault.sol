// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC4626.sol";

contract MyVault is ERC4626 {
    constructor(ERC20 asset_) ERC20("Vault Share", "vMTK") ERC4626(asset_) {}

    function simulateYield(uint256 amount) external {
        ERC20(asset()).transferFrom(msg.sender, address(this), amount);
    }
}
