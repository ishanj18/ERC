// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MockToken.sol";
import "../src/MyVault.sol";

contract MyVaultTest is Test {
    MockToken token;
    MyVault vault;

    address alice = address(1);

    function setUp() public {
        token = new MockToken();
        vault = new MyVault(token);

        token.mint(alice, 1000 ether);
    }

    function testDeposit() public {
        vm.startPrank(alice);

        token.approve(address(vault), 100 ether);

        vault.deposit(100 ether, alice);

        assertGt(vault.balanceOf(alice), 0);

        vm.stopPrank();
    }

    function testWithdraw() public {
        vm.startPrank(alice);

        token.approve(address(vault), 100 ether);

        vault.deposit(100 ether, alice);

        uint256 shares = vault.balanceOf(alice);

        vault.redeem(shares, alice, alice);

        assertEq(vault.balanceOf(alice), 0);

        vm.stopPrank();
    }

    function testYieldSimulation() public {
        vm.startPrank(alice);

        token.approve(address(vault), 200 ether);

        vault.deposit(100 ether, alice);

        vault.simulateYield(100 ether);

        assertEq(token.balanceOf(address(vault)), 200 ether);

        vm.stopPrank();
    }
}
