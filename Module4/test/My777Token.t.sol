// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/My777Token.sol";

contract My777TokenTest is Test {
    My777Token token;

    function setUp() public {
        token = new My777Token(1000 ether);
    }

    function testInitialSupply() public {
        assertEq(token.totalSupply(), 1000 ether);
    }
}
