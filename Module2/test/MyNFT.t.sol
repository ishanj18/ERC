// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/MyNFT.sol";

contract MyNFTTest is Test {
    MyNFT nft;

    address alice = address(1);

    function setUp() public {
        nft = new MyNFT("https://example.com/");
    }

    function testMint() public {
        nft.mint(alice);
        assertEq(nft.ownerOf(1), alice);
    }

    function testSequentialTokenIds() public {
        nft.mint(alice);
        nft.mint(alice);

        assertEq(nft.ownerOf(1), alice);
        assertEq(nft.ownerOf(2), alice);
    }

    function testRoyalty() public {
        (address receiver, uint256 royaltyAmount) = nft.royaltyInfo(
            1,
            100 ether
        );

        assertEq(receiver, address(this));
        assertEq(royaltyAmount, 5 ether);
    }
}
