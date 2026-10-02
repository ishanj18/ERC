// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MyERC165.sol";
import "@openzeppelin/contracts/interfaces/IERC721.sol";
import "@openzeppelin/contracts/interfaces/IERC2981.sol";

contract MyERC165Test is Test {
    MyERC165 checker;

    function setUp() public {
        checker = new MyERC165();
    }

    function testERC721Support() public {
        assertTrue(checker.supportsInterface(type(IERC721).interfaceId));
    }

    function testERC2981Support() public {
        assertTrue(checker.supportsInterface(type(IERC2981).interfaceId));
    }

    function testCompatibilityCheck() public {
        assertTrue(
            checker.checkCompatibility(
                address(checker),
                type(IERC721).interfaceId
            )
        );
    }
}
