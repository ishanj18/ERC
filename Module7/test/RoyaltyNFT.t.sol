// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/RoyaltyNFT.sol";

contract RoyaltyNFTTest is Test {
    RoyaltyNFT nft;

    function setUp() public {
        nft = new RoyaltyNFT();
    }

    function testMint() public {
        address alice = address(1);

        nft.mint(alice);

        assertEq(nft.ownerOf(0), alice);
    }

    function testRoyaltyCalculation() public {
        (address receiver, uint256 royalty) = nft.royaltyInfo(0, 100 ether);

        assertEq(receiver, address(this));

        assertEq(royalty, 5 ether);
    }
}
