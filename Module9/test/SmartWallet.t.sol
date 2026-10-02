// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

import "../src/SmartWallet.sol";

contract SmartWalletTest is Test {
    SmartWallet wallet;

    address owner = address(1);

    address guardian1 = address(2);
    address guardian2 = address(3);

    address newOwner = address(4);

    function setUp() public {
        address[] memory guardians = new address[](2);

        guardians[0] = guardian1;
        guardians[1] = guardian2;

        wallet = new SmartWallet(owner, guardians);
    }

    function testInitialOwner() public {
        assertEq(wallet.owner(), owner);
    }

    function testSocialRecovery() public {
        vm.prank(guardian1);
        wallet.recoverOwner(newOwner);

        vm.prank(guardian2);
        wallet.recoverOwner(newOwner);

        assertEq(wallet.owner(), newOwner);
    }
}
