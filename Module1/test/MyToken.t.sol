// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken token;

    address alice = address(1);
    address bob = address(2);
    address treasury = address(100);

    function setUp() public {
        token = new MyToken(1000, treasury);
    }

    function testTransferUpdatesBalances() public {
        token.transfer(alice, 100 ether);

        assertEq(token.balanceOf(alice), 99 ether);
        assertEq(token.balanceOf(treasury), 1 ether);
    }

    function testTransferFromReducesAllowance() public {
        token.transfer(alice, 200 ether);

        vm.prank(alice);
        token.approve(bob, 50 ether);

        vm.prank(bob);
        token.transferFrom(alice, bob, 20 ether);

        assertEq(token.allowance(alice, bob), 30 ether);
    }

    function testOnlyOwnerCanMint() public {
        token.mint(alice, 100 ether);

        assertEq(token.balanceOf(alice), 100 ether);
    }

    function testCannotTransferToZeroAddress() public {
        vm.expectRevert();

        token.transfer(address(0), 10 ether);
    }
}
